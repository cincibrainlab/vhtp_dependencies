classdef MRIRandomComparisonBUD < MRIMeasureBUD
    % MRIRandomComparisonBUD < MRIMeasureBUD : Fixed density binary undirected MRI random comparison
    %   MRIRandomComparisonBUD represents MRI comparison of binary undirected graph with fixed density with random graphs.
    %
    % MRIRandomComparisonBUD properties (Access = protected):
    %   props   -   cell array of object properties < ListElement
    %
    % MRIRandomComparisonBUD properties (Constants):
    %   CODE                -   code numeric code < MRIMeasure
    %   CODE_TAG            -   code tag < MRIMeasure
    %   CODE_FORMAT         -   code format < MRIMeasure
    %   CODE_DEFAULT        -   code default < MRIMeasure
    %
    %   PARAM               -   parameters numeric code < MRIMeasure
    %   PARAM_TAG           -   parameters tag < MRIMeasure
    %   PARAM_FORMAT        -   parameters format < MRIMeasure
    %   PARAM_DEFAULT       -   parameters default < MRIMeasure
    %
    %   NOTES               -   notes numeric code < MRIMeasure
    %   NOTES_TAG           -   notes tag < MRIMeasure
    %   NOTES_FORMAT        -   notes format < MRIMeasure
    %   NOTES_DEFAULT       -   notes default < MRIMeasure
    %
    %   GROUP1              -   group1 numeric code < MRIMeasure
    %   GROUP1_TAG          -   group1 tag < MRIMeasure
    %   GROUP1_FORMAT       -   group1 format < MRIMeasure
    %   GROUP1_DEFAULT      -   group1 default < MRIMeasure
    %
    %   VALUES1             -   values1 numeric code < MRIMeasure
    %   VALUES1_TAG         -   values1 tag < MRIMeasure
    %   VALUES1_FORMAT      -   values1 format < MRIMeasure
    %   VALUES1_DEFAULT     -   values1 default < MRIMeasure
    %
    %   DENSITY             -   density numeric code < MRIMeasureBUD
    %   DENSITY_TAG     	-   density tag < MRIMeasureBUD
    %   DENSITY_FORMAT      -   density format < MRIMeasureBUD
    %   DENSITY_DEFAULT     -   density default < MRIMeasureBUD
    %
    %   THRESHOLD1          -   threshold numeric code < MRIMeasureBUD
    %   THRESHOLD1_TAG      -   threshold tag < MRIMeasureBUD
    %   THRESHOLD1_FORMAT   -   threshold format < MRIMeasureBUD
    %   THRESHOLD1_DEFAULT  -   threshold default < MRIMeasureBUD
    %
    %   dDENSITY            -   d density value < MRIMeasureBUD
    %   DENSITY_LEVELS      -   density intervals < MRIMeasureBUD
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
    % MRIRandomComparisonBUD methods:
    %   MRIRandomComparisonBUD  -   constructor
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
    % MRIRandomComparisonBUD methods (Static):
    %   cleanXML    -   removes whitespace nodes from xmlread < ListElement
    %   propnumber  -   number of properties
    %   getTags     -   cell array of strings with the tags of the properties
    %   getFormats  -   cell array with the formats of the properties
    %   getDefaults -   cell array with the defaults of the properties
    %   getOptions  -   cell array with options (only for properties with options format)
    %
    % See also MRIMeasureBUD, MRIRandomComparisonBUT, MRIRandomComparisonWU.

    % Author: Mite Mijalkov, Ehsan Kakaei & Giovanni Volpe
    % Date: 2016/01/01

    properties (Constant)
        
        % measure values random graphs
        RANDOM_COMP_VALUES = MRIMeasureBUD.propnumber() + 1
        RANDOM_COMP_TAG = 'random graph values'
        RANDOM_COMP_FORMAT = BNC.NUMERIC
        RANDOM_COMP_DEFAULT = NaN
        
        % one-tailed p-value
        PVALUE1 = MRIMeasureBUD.propnumber() + 2
        PVALUE1_TAG = 'pvalue1'
        PVALUE1_FORMAT = BNC.NUMERIC
        PVALUE1_DEFAULT = NaN
        
        % two-tailed p-value
        PVALUE2 = MRIMeasureBUD.propnumber() + 3
        PVALUE2_TAG = 'pvalue2'
        PVALUE2_FORMAT = BNC.NUMERIC
        PVALUE2_DEFAULT = NaN
        
        % percentiles
        PERCENTILES = MRIMeasureBUD.propnumber() + 4
        PERCENTILES_TAG = 'percentiles'
        PERCENTILES_FORMAT = BNC.NUMERIC
        PERCENTILES_DEFAULT = NaN
        
    end
    methods
        function n = MRIRandomComparisonBUD(varargin)
            % MRIRANDOMCOMPARISONBUD() creates binary undirected with fixed density MRI comparisons with random graphs.
            %
            % MRICOMPARISONBUD(Tag1,Value1,Tag2,Value2,...) initializes property Tag1 to Value1,
            %   Tag2 to Value2, ... .
            %   Admissible properties are:
            %       MRIRandomComparisonBUD.CODE                 -   numeric
            %       MRIRandomComparisonBUD.PARAM                -   numeric
            %       MRIRandomComparisonBUD.NOTES                -   char
            %       MRIRandomComparisonBUD.GROUP1               -   numeric
            %       MRIRandomComparisonBUD.VALUES1              -   numeric
            %       MRIRandomComparisonBUD.DENSITY              -   numeric
            %       MRIRandomComparisonBUD.THRESHOLD1           -   numeric
            %       MRIRandomComparisonBUD.RANDOM_COMP_VALUES   -   numeric
            %       MRIRandomComparisonBUD.PVALUE1              -   numeric
            %       MRIRandomComparisonBUD.PVALUE2              -   numeric
            %       MRIRandomComparisonBUD.PERCENTILES          -   numeric
            %
            % See also MRIRandomComparisonBUD.

            n = n@MRIMeasureBUD(varargin{:});
        end
        function d = diff(n)
            % DIFF difference between two measures
            %
            % D = DIFF(N) returns the difference D between the two measures that are constituents
            %   of the comparison with random graphs N.
            %
            % See also MRIRandomComparisonBUD.
            
            d = n.getProp(MRIRandomComparisonBUD.RANDOM_COMP_VALUES)-n.getProp(MRIRandomComparisonBUD.VALUES1);
        end
        function ci = CI(n,p)
            % CI confidence interval calculated for a comparison
            %
            % CI = CI(N,P) returns the confidence interval CI of the comparison
            %   with random graphs N given the P-quantiles of the percentiles of N.
            %
            % See also MRIRandomComparisonBUD.

            p = round(p);
            percentiles = n.getProp(MRIRandomComparisonBUD.PERCENTILES);
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
            % See also MRIRandomComparisonBUD, isComparison, isRandom.
            
            bool = false;
        end
        function bool = isComparison(n)
            % ISCOMPARISON return true if comparison
            %
            % BOOL = ISCOMPARISON(N) returns false for comparison with random graphs.
            %
            % See also MRIRandomComparisonBUD, isMeasure, isRandom.
            
            bool = false;
        end
        function bool = isRandom(n)
            % ISRANDOM return true if comparison with random graphs
            %
            % BOOL = ISRANDOM(N) returns true for comparison with random graphs.
            %
            % See also MRIRandomComparisonBUD, isMeasure, isComparison.
            
            bool = true;
        end
    end
    methods (Static)
        function N = propnumber()
            % PROPNUMBER number of properties
            %
            % N = PROPNUMBER() gets the total number of properties of MRIRandomComparisonBUD.
            %
            % See also MRIRandomComparisonBUD.

            N = MRIMeasureBUD.propnumber() + 4;
        end
        function tags = getTags()
            % GETTAGS cell array of strings with the properties' tags
            %
            % TAGS = GETTAGS() returns a cell array of strings with the tags 
            %   of all properties of MRIRandomComparisonBUD.
            %
            % See also MRIRandomComparisonBUD, ListElement.
            
            tags = [ MRIMeasureBUD.getTags() ...
                MRIRandomComparisonBUD.RANDOM_COMP_TAG ...
                MRIRandomComparisonBUD.PVALUE1_TAG ...
                MRIRandomComparisonBUD.PVALUE2_TAG ...
                MRIRandomComparisonBUD.PERCENTILES_TAG];
        end
        function formats = getFormats()
            % GETFORMATS cell array with the formats of the properties
            %
            % FORMATS = GETFORMATS() returns a cell array with the formats
            %   of all properties of MRIRandomComparisonBUD.
            %
            % See also MRIRandomComparisonBUD, ListElement.
            
            formats = [MRIMeasureBUD.getFormats() ...
                MRIRandomComparisonBUD.RANDOM_COMP_FORMAT ...
                MRIRandomComparisonBUD.PVALUE1_FORMAT ...
                MRIRandomComparisonBUD.PVALUE2_FORMAT ...
                MRIRandomComparisonBUD.PERCENTILES_FORMAT];
        end
        function options = getOptions(~)  % (i)
            % GETOPTIONS cell array with options (only for properties with options format)
            %
            % OPTIONS = GETOPTIONS(PROP) returns a cell array containing the options
            %   of the properties specified by PROP of MRIRandomComparisonBUD.
            %   If the PROP is not "options", it returns an empty cell array. 
            %
            % See also MRIRandomComparisonBUD, ListElement.
            
            options = {};
        end
        function defaults = getDefaults()
            % GETDEFAULTS cell array with the default values of the properties
            %
            % DEFAULTS = GETDEFAULTS() returns a cell array with the default values
            %   of all properties of MRIRandomComparisonBUD.
            %
            % See also MRIRandomComparisonBUD, ListElement.
            
            defaults = [MRIMeasureBUD.getDefaults() ...
                MRIRandomComparisonBUD.RANDOM_COMP_DEFAULT ...
                MRIRandomComparisonBUD.PVALUE1_DEFAULT ...
                MRIRandomComparisonBUD.PVALUE2_DEFAULT ...
                MRIRandomComparisonBUD.PERCENTILES_DEFAULT];
        end
    end
    
end