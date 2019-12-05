___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "categories": [
    "UTILITY"
  ],
  "displayName": "Elapsed Time",
  "description": "Get the elapsed time since the GTM snippet tag started processing.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "LABEL",
    "name": "helpText",
    "displayName": "Get the elapsed time at each timing since the GTM snippet tag started processing.\u003cbr\u003e\nThe value is a \u003cb\u003enumber\u003c/b\u003e and the unit is \u003cb\u003emilliseconds\u003c/b\u003e."
  },
  {
    "type": "GROUP",
    "name": "moreSettings",
    "displayName": "More Settings",
    "groupStyle": "ZIPPY_OPEN_ON_PARAM",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "appendStringToEnd",
        "checkboxText": "Append string to end",
        "simpleValueType": true,
        "subParams": [
          {
            "type": "TEXT",
            "name": "appendString",
            "displayName": "",
            "simpleValueType": true,
            "enablingConditions": [
              {
                "paramName": "appendStringToEnd",
                "paramValue": true,
                "type": "EQUALS"
              }
            ],
            "valueHint": "e.g. ms"
          }
        ],
        "help": "The value type changes from Number to String."
      },
      {
        "type": "CHECKBOX",
        "name": "convertToSeconds",
        "checkboxText": "Convert to seconds",
        "simpleValueType": true,
        "subParams": [
          {
            "type": "SELECT",
            "name": "mathSelect",
            "displayName": "",
            "macrosInSelect": false,
            "selectItems": [
              {
                "value": "ceil",
                "displayValue": "Round up"
              },
              {
                "value": "round",
                "displayValue": "Rounding off"
              },
              {
                "value": "floor",
                "displayValue": "Round down"
              },
              {
                "value": "original",
                "displayValue": "None round"
              }
            ],
            "simpleValueType": true,
            "defaultValue": "round",
            "enablingConditions": [
              {
                "paramName": "convertToSeconds",
                "paramValue": true,
                "type": "EQUALS"
              }
            ]
          }
        ]
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// set APIs
const getTimestamp = require('getTimestamp');
const currentTime = getTimestamp();
const dataLayer = require('copyFromDataLayer');
const queryPermission = require('queryPermission');

// return Value
if(queryPermission('read_data_layer', 'gtm.start')){
	// functions
	const getTime = function(c){
		return (!c) ? currentTime - dataLayer('gtm.start') : (currentTime - dataLayer('gtm.start')) / c;
	};
	const appendString = function(v){
		return (data.appendStringToEnd && data.appendString) ? v + data.appendString : v;
	};
	
	// returns
	if(!data.convertToSeconds){
		return appendString(getTime());
	}else{
		const Math = require('Math');
		switch(data.mathSelect){
			case 'ceil':
				return appendString(Math.ceil(getTime(1000)));
			case 'round':
				return appendString(Math.round(getTime(1000)));
			case 'floor':
				return appendString(Math.floor(getTime(1000)));
			default:
				return appendString(getTime(1000));
		}
	}
}else{
	return undefined;
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "gtm.start"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: None settings
  code: |-
    // Call runCode to run the template's code.
    let variableResult = runCode({});

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: Set convertToSeconds
  code: "// Call runCode to run the template's code.\nlet variableResult = runCode({\n\
    \tconvertToSeconds: true,\n\tmathSelect: 'original'\n});\n\n// Verify that the\
    \ variable returns a result.\nassertThat(variableResult).isNotEqualTo(undefined);"
- name: Set convertToSeconds and mathSelect - ceil
  code: "// Call runCode to run the template's code.\nlet variableResult = runCode({\n\
    \tconvertToSeconds: true,\n\tmathSelect: 'ceil'\n});\n\n// Verify that the variable\
    \ returns a result.\nassertThat(variableResult).isNotEqualTo(undefined);"
- name: Set convertToSeconds and mathSelect - round
  code: "// Call runCode to run the template's code.\nlet variableResult = runCode({\n\
    \tconvertToSeconds: true,\n\tmathSelect: 'round'\n});\n\n// Verify that the variable\
    \ returns a result.\nassertThat(variableResult).isNotEqualTo(undefined);"
- name: Set convertToSeconds and mathSelect - floor
  code: "// Call runCode to run the template's code.\nlet variableResult = runCode({\n\
    \tconvertToSeconds: true,\n\tmathSelect: 'floor'\n});\n\n// Verify that the variable\
    \ returns a result.\nassertThat(variableResult).isNotEqualTo(undefined);"
- name: Set appendStringToEnd, Not set appendString
  code: "// Call runCode to run the template's code.\nlet variableResult = runCode({\n\
    \tappendStringToEnd: true\n});\n\n// Verify that the variable returns a result.\n\
    assertThat(variableResult).isNotEqualTo(undefined);"
- name: Set appendString - ms
  code: "// Call runCode to run the template's code.\nlet variableResult = runCode({\n\
    \tappendStringToEnd: true,\n\tappendString: 'ms'\n});\n\n// Verify that the variable\
    \ returns a result.\nassertThat(variableResult).isNotEqualTo(undefined);"
- name: Set convertToSeconds and appendString - ms
  code: "// Call runCode to run the template's code.\nlet variableResult = runCode({\n\
    \tconvertToSeconds: true,\n\tmathSelect: 'original',\n\tappendStringToEnd: true,\n\
    \tappendString: 'ms'\n});\n\n// Verify that the variable returns a result.\nassertThat(variableResult).isNotEqualTo(undefined);"
- name: Set convertToSeconds - round, and appendString - s
  code: "// Call runCode to run the template's code.\nlet variableResult = runCode({\n\
    \tconvertToSeconds: true,\n\tmathSelect: 'round',\n\tappendStringToEnd: true,\n\
    \tappendString: 's'\n});\n\n// Verify that the variable returns a result.\nassertThat(variableResult).isNotEqualTo(undefined);"


___NOTES___

Created on 2019/12/5 19:09:22


