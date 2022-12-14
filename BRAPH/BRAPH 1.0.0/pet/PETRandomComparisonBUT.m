classdef PETRandomComparisonBUT < PETMeasureBUT
    % PETRandomComparisonBUT < PETMeasureBUT : Fixed threshold binary undirected PET random comparison
    %   PETRandomComparisonBUT represents PET comparison of binary undirected graph with fixed threshold with random graphs.
    %
    % PETRandomComparisonBUT properties (Access = protected):
    %   props   -   cell array of object properties < ListElement
    %
    % PETRandomComparisonBUT properties (Constants):
    %   CODE                -   code numeric code < PETMeasure
    %   CODE_TAG            -   code tag < PETMeasure
    %   CODE_FORMAT         -   code format < PETMeasure
    %   CODE_DEFAULT        -   code default < PETMeasure
    %
    %   PARAM               -   parameters numeric code < PETMeasure
    %   PARAM_TAG           -   parameters tag < PETMeasure
    %   PARAM_FORMAT        -   parameters format < PETMeasure
    %   PARAM_DEFAULT       -   parameters default < PETMeasure
    %
    %   NOTES               -   notes numeric code < PETMeasure
    %   NOTES_TAG           -   notes tag < PETMeasure
    %   NOTES_FORMAT        -   notes format < PETMeasure
    %   NOTES_DEFAULT       -   notes default < PETMeasure
    %
    %   GROUP1              -   group1 numeric code < PETMeasure
    %   GROUP1_TAG          -   group1 tag < PETMeasure
    %   GROUP1_FORMAT       -   group1 format < PETMeasure
    %   GROUP1_DEFAULT      -   group1 default < PETMeasure
    %
    %   VALUES1             -   values1 numeric code < PETMeasure
    %   VALUES1_TAG         -   values1 tag < PETMeasure
    %   VALUES1_FORMAT      -   values1 format < PETMeasure
    %   VALUES1_DEFAULT     -   values1 default < PETMeasure
    %
    %   THRESHOLD           -   threshold numeric code < PETMeasureBUT
    %   THRESHOLD_TAG       -   threshold tag < PETMeasureBUT
    %   THRESHOLD_FORMAT    -   threshold format < PETMeasureBUT
    %   THRESHOLD_DEFAULT   -   threshold default < PETMeasureBUT
    %
    %   DENSITY1            -   density 1 numeric code < PETMeasureBUT
    %   DENSITY1_TAG        -   density 1 tag < PETMeasureBUT
    %   DENSITY1_FORMAT     -   density 1 format < PETMeasureBUT
    %   DENSITY1_DEFAULT    -   density 1 default < PETMeasureBUT
    %
    %   dTHRESHOLD          -   d threshold value < PETMeasureBUT
    %   THRESHOLD_LEVELS    -   level of threshold < PETMeasureBUT
    %
    %   RANDOM_COMP_VALUES  -   random graph values numeric code
    %   RANDOM_COMP_TAG     -   random graph values tag
    %   RANDOM_COMP_FORMAT  -   random graph values format
    %   RANDOM_COMP_DEFAULT -   random graph values default
    %
    %   PVALUE1             -   one tailed p-value numeric code
    %   PVALUE1_TAG         -   one tailed p-value tag
    %   PVALUE1_FORMAT      -   one tailed p-value format
    %   PVALUE1_DEFAULT     -   one tailed p-value default
    %
    %   PVALUE2             -   two tailed p-value numeric code
    %   PVALUE2_TAG         -   two tailed p-value tag
    %   PVALUE2_FORMAT      -   two tailed p-value format
    %   PVALUE2_DEFAULT     -   two tailed p-value default
    %
    %   PERCENTILES         -   percentiles numeric code
    %   PERCENTILES_TAG     -   percentiles tag
    %   PERCENTILES_FORMAT  -   percentiles format
    %   PERCENTILES_DEFAULT -   percentiles default
    %
    % PETRandomComparisonBUT methods:
    %   PETRandomComparisonBUT  -   constructor
    %   setProp                 -   sets property value < ListElement
    %   getProp                 -   gets property value, format and tag < ListElement
    %   getPropValue            -   string of property value < ListElement
    %   getPropFormat           -   string of property format < ListElement
    %   getPropTag              -   string of property tag < ListElement
    %   diff                    -   difference between two measures
    %   CI                      -   confidence interval calculated for a comparison
    %   isMeasure               -   return true if measure
    %   isComparison            -   return true if comparison
    %   isRandom                -   return true if comparison with random graphs
    %
    % PETRandomComparisonBUT methods (Static):
    %   cleanXML    -   removes whitespace nodes from xmlread < ListElement
    %   propnumber  -   number of properties
    %   getTags     -   cell array of strings with the tags of the properties
    %   getFormats  -   cell array with the formats of the properties
    %   getDefaults -   cell array with the defaults of the properties
    %   getOptions  -   cell array with options (only for properties with options format)
    %
    % See also PETMeasureBUT, PETRandomComparisonBUD, PETRandomComparisonWU.

    % Author: Mite Mijalkov, Ehsan Kakaei & Giovanni Volpe
    % Date: 2016/01/01
    
    properties (Constant)
        
        % measure values random graphs
        RANDOM_COMP_VALUES = PETMeasureBUT.propnumber() + 1
        RANDOM_COMP_TAG = 'random graph values'
        RANDOM_COMP_FORMAT = BNC.NUMERIC
        RANDOM_COMP_DEFAULT = NaN
        
        % one-tailed p-value
        PVALUE1 = PETMeasureBUT.propnumber() + 2
        PVALUE1_TAG = 'pvalue1'
        PVALUE1_FORMAT = BNC.NUMERIC
        PVALUE1_DEFAULT = NaN
        
        % two-tailed p-value
        PVALUE2 = PETMeasureBUT.propnumber() + 3
        PVALUE2_TAG = 'pvalue2'
        PVALUE2_FORMAT = BNC.NUMERIC
        PVALUE2_DEFAULT = NaN
        
        % percentiles
        PERCENTILES = PETMeasureBUT.propnumber() + 4
        PERCENTILES_TAG = 'percentiles'
        PERCENTILES_FORMAT = BNC.NUMERIC
        PERCENTILES_DEFAULT = NaN
        
    end
    methods
        function n = PETRandomComparisonBUT(varargin)
            % PETRANDOMCOMPARISONBUT() creates binary undirected with fixed threshold PET comparisons with random graphs.
            %
            % PETRANDOMCOMPARISONBUT(Tag1,Value1,Tag2,Value2,...) initializes property Tag1 to Value1,
            %   Tag2 to Value2, ... .
            %   Admissible properties are:
            %       PETRandomComparisonBUT.CODE                 -   numeric
            %       PETRandomComparisonBUT.PARAM                -   numeric
            %       PETRandomComparisonBUT.NOTES                -   char
            %       PETRandomComparisonBUT.GROUP1               -   numeric
            %       PETRandomComparisonBUT.VALUES1              -   numeric
            %       PETRandomComparisonBUT.DENSITY1             -   numeric
            %       PETRandomComparisonBUT.THRESHOLD            -   numeric
            %       PETRandomComparisonBUD.RANDOM_COMP_VALUES   -   numeric
            %       PETRandomComparisonBUT.PVALUE1              -   numeric
            %       PETRandomComparisonBUT.PVALUE2              -   numeric
            %       PETRandomComparisonBUT.PERCENTILES          -   numeric
            %
            % See also PETRandomComparisonBUT.

            n = n@PETMeasureBUT(varargin{:});
        end
        function d = diff(n)
            % DIFF difference between two measures
            %
            % D = DIFF(N) returns the difference D between the two measures that are constituents
            %   of the comparison with random graphs N.
            %
            % See also PETRandomComparisonBUT.
            
            d = n.getProp(PETRandomComparisonBUT.RANDOM_COMP_VALUES)-n.getProp(PETRandomComparisonBUT.VALUES1);
        end
        function ci = CI(n,p)
            % CI confidence interval calculated for a comparison
            %
            % CI = CI(N,P) returns the confidence interval CI of the comparison
            %   with random graphs N given the P-quantiles of the percentiles of N.
            %
            % See also PETRandomComparisonBUT.
            
            p = round(p);
            percentiles = n.getProp(PETRandomComparisonBUT.PERCENTILES);
            if p==50
                ci = percentiles(51,:);
            elseif p>=0 && p<50
                ci = [percentiles(p+1,:); percentiles(101-p,:)];
            else
                ci = NaN;
            end
        end
        function bool = isMeasure(n)
            % ISMEASURE return true if measure
            %
            % BOOL = ISMEASURE(N) returns false for comparison with random graphs.
            %
            % See also PETRandomComparisonBUT, isComparison, isRandom.
            
            bool = false;
        end
        function bool = isComparison(n)
            % ISCOMPARISON return true if comparison
            %
            % BOOL = ISCOMPARISON(N) returns false for comparison with random graphs.
            %
            % See also PETRandomComparisonBUT, isMeasure, isRandom.

            bool = false;
        end
        function bool = isRandom(n)
            % ISRANDOM return true if comparison with random graphs
            %
            % BOOL = ISRANDOM(N) returns true for comparison with random graphs.
            %
            % See also PETRandomComparisonBUT, isMeasure, isComparison.
            
            bool = true;
        end
    end
    methods (Static)
        function N = propnumber()
            % PROPNUMBER number of properties
            %
            % N = PROPNUMBER() gets the total number of properties of PETRandomComparisonBUT.
            %
            % See also PETRandomComparisonBUT.

            N = PETMeasureBUT.propnumber() + 4;
        end
        function tags = getTags()
            % GETTAGS cell array of strings with the properties' tags
            %
            % TAGS = GETTAGS() returns a cell array of strings with the tags 
            %   of all properties of PETRandomComparisonBUT.
            %
            % See also PETRandomComparisonBUT, ListElement.
            
            tags = [ PETMeasureBUT.getTags() ...
                PETRandomComparisonBUT.RANDOM_COMP_TAG ...
                PETRandomComparisonBUT.PVALUE1_TAG ...
                PETRandomComparisonBUT.PVALUE2_TAG ...
                PETRandomComparisonBUT.PERCENTILES_TAG];
        end
        function formats = getFormats()
            % GETFORMATS cell array with the formats of the properties
            %
            % FORMATS = GETFORMATS() returns a cell array with the formats
            %   of all properties of PETRandomComparisonBUT.
            %
            % See also PETRandomComparisonBUT, ListElement.
            
            formats = [PETMeasureBUT.getFormats() ...
                PETRandomComparisonBUT.RANDOM_COMP_FORMAT ...
                PETRandomComparisonBUT.PVALUE1_FORMAT ...
                PETRandomComparisonBUT.PVALUE2_FORMAT ...
                PETRandomComparisonBUT.PERCENTILES_FORMAT];
        end
        function options = getOptions(~)  % (i)
            % GETOPTIONS cell array with options (only for properties with options format)
            %
            % OPTIONS = GETOPTIONS(PROP) returns a cell array containing the options
            %   of the properties specified by PROP of PETRandomComparisonBUT.
            %   If the PROP is not "options", it returns an empty cell array. 
            %
            % See also PETRandomComparisonBUT, ListElement.
            
            options = {};
        end
        function defaults = getDefaults()
            % GETDEFAULTS cell array with the default values of the properties
            %
            % DEFAULTS = GETDEFAULTS() returns a cell array with the default values
            %   of all properties of PETRandomComparisonBUT.
            %
            % See also PETRandomComparisonBUT, ListElement.
            
            defaults = [PETMeasureBUT.getDefaults() ...
                PETRandomComparisonBUT.RANDOM_COMP_DEFAULT ...
                PETRandomComparisonBUT.PVALUE1_DEFAULT ...
                PETRandomComparisonBUT.PVALUE2_DEFAULT ...
                PETRandomComparisonBUT.PERCENTILES_DEFAULT];
        end
    end 
end