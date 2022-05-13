"use strict";

import UniqueID from "./unique.js";

import {
  toKebab,
  isFunctionInstance,
  isArrayInstance,
} from "./helpers.js";


// utiility for creating fast dom elements and styles
const Element = () => {

  // Single Stylesheet that used by every element created
  const styleSheet = document.createElement("style");
  const htmlHead = document.querySelector("head");
  htmlHead.appendChild(styleSheet);

  return (elementInput) => {

    // Single element
    let element = (!isArrayInstance(elementInput)) ? (elementInput || null) : null;
    let elementID = null;

    // Group elements
    let elements = isArrayInstance(elementInput) ? (elementInput || []) : [];

    // Share 
    let elementStyle = {};
    let elementWatchers = null;
    let elementClassName = null
    let elementMethods = null;

    const cleanQueryPunctuation = (queryName) => queryName.replace(/\.|#/g, "");

    const setWatcher = (elementWatchersParam, watchersCallback) => {
      elementWatchers = elementWatchersParam;

      if (watchersCallback) watchersCallback(elementWatchersParam);

      return elementMethods;
    };

    const getWatchers = () => {
      return elementWatchers;
    };

    const createElement = (elementType, elementCount) => {
      let elementTypeTemp = null;

      if (elements.length) return elementMethods;

      if (isFunctionInstance(elementType)) elementTypeTemp = elementType();
      else elementTypeTemp = elementType;

      if (elementCount) {
        for (let i = 0; i < elementCount; i++) {
          elements.push(document.createElement(elementTypeTemp));
        }
      } else {
        if (element === null) {
          element = document.createElement(elementTypeTemp);
        }
      }

      return elementMethods;
    };

    const queryElement = (elementQuery) => {
      let elementQueryTemp = null;

      if (element) return elementMethods;
      if (elements.length) return elementMethods;

      if (isFunctionInstance(elementQuery)) elementQueryTemp = elementQuery();
      else elementQueryTemp = elementQuery;

      element = document.querySelector(elementQueryTemp);

      return elementMethods;
    };

    const appendChildren = (elementChildren) => {
      let elementChildrenTemp = null;

      // for array elements
      if (isFunctionInstance(elementChildren)) elementChildrenTemp = elementChildren();

      // extract array of elements created from one Element function
      else if (elementChildren.init) elementChildrenTemp = elementChildren.init();

      // for single element
      else elementChildrenTemp = elementChildren;

      for (const elementChild of elementChildrenTemp) {
        if (elementChild.init === undefined) {
          element.appendChild(elementChild)
          continue;
        }
        element.appendChild(elementChild.init())
      }

      return elementMethods;
    };


    const append = (elementChildren) => {
      let elementChildrenTemp = null;

      // for array elements
      if (isFunctionInstance(elementChildren)) elementChildrenTemp = elementChildren();

      // extract array of elements created from one Element function
      else if (elementChildren.init) elementChildrenTemp = elementChildren.init();

      // for single element
      else elementChildrenTemp = elementChildren;

      for (const elementChild of elementChildrenTemp) {
        if (elementChild.init === undefined) {
          console.log(elementChild)
          element.append(elementChild)
          continue;
        }
        element.append(elementChild.init())
      }

      return elementMethods;
    };

    const appendChild = (elementChild) => {
      let elementChildTemp = null;

      if (elements.length) return elementMethods;

      if (isFunctionInstance(elementChild)) elementChildTemp = elementChild();
      else elementChildTemp = elementChild;

      if (elementChildTemp.init === undefined) element.appendChild(elementChildTemp);
      else element.appendChild(elementChildTemp.init());

      return elementMethods;
    };

    const prependChildren = (elementChildren) => {
      let elementChildrenTemp = null;

      if (elements.length) return elementMethods;

      if (isFunctionInstance(elementChildren)) elementChildrenTemp = elementChildren();
      else elementChildrenTemp = elementChildren;

      for (const elementChild of elementChildrenTemp) {
        if (elementChild.init === undefined) {
          element.prependChild(elementChild)
          continue;
        }
        element.prependChild(elementChild.init())
      }
      return elementMethods;
    };

    const prepend = (elementChildren) => {
      let elementChildrenTemp = null;

      if (elements.length) return elementMethods;

      if (isFunctionInstance(elementChildren)) elementChildrenTemp = elementChildren();
      else elementChildrenTemp = elementChildren;

      for (const elementChild of elementChildrenTemp) {
        if (elementChild.init === undefined) {
          element.prepend(elementChild)
          continue;
        }
        element.prepend(elementChild.init())
      }
      return elementMethods;
    };

    const prependChild = (elementChild) => {
      let elementChildTemp = null;

      if (elements.length) return elementMethods;

      if (isFunctionInstance(elementChild)) elementChildTemp = elementChild();
      else elementChildTemp = elementChild;

      if (elementChild.init === undefined) element.prependChild(elementChildTemp);
      else element.prependChild(elementChildTemp.init());

      return elementMethods;
    };

    const setInnerText = (elementText) => {
      let elementTextTemp = null;

      if (elements.length) return elementMethods;

      if (isFunctionInstance(elementText)) elementTextTemp = elementText();
      else elementTextTemp = elementText;

      element.innerText = elementTextTemp;

      return elementMethods;
    };

    const getClass = () => elementClassName;

    const setClass = (className) => {
      let classNameTemp = null;

      if (isFunctionInstance(className)) classNameTemp = className();
      else classNameTemp = className;

      if (elements.length) {
        elements.forEach((element => {
          element.setAttribute("class", classNameTemp);
          elementClassName = classNameTemp;
        }))

        return elementMethods
      };

      element.setAttribute("class", classNameTemp);
      elementClassName = classNameTemp;

      return elementMethods;
    };

    const addClass = (className) => {
      let classNameTemp = null;

      if (elements.length) return elementMethods;

      if (isFunctionInstance(className)) classNameTemp = className();
      else classNameTemp = className;

      element.classList.add(classNameTemp);
      elementClassName = classNameTemp;

      return elementMethods;
    };

    const removeClass = (className) => {
      let classNameTemp = null;

      if (elements.length) return elementMethods;

      if (isFunctionInstance(className)) classNameTemp = className();
      else classNameTemp = className;

      element.classList.remove(classNameTemp);
      elementClassName = element.getAttribute("class");

      return elementMethods;
    };

    const getID = () => {

      if (elements.length) return elementMethods;

      return elementID
    };

    const setID = (id) => {

      if (elements.length) return elementMethods;

      element.setAttribute("id", id)

      return elementMethods;
    };


    const setAttribute = (elementAttribute, elementAttributeData) => {

      if (elements.length) return elementMethods;

      element.setAttribute(elementAttribute, elementAttributeData)

      return elementMethods;
    };


    const getAttribute = (elementAttribute) => {

      if (elements.length) return elementMethods;

      return element.getAttribute(elementAttribute)
    }

    const css = (queryName = "", cssStyleObject) => {

      const toString = (key, cssStyleObject) => {
        const CSS_VALUE = 1;

        const pseudoFilter = Object.entries(cssStyleObject).filter(
          (cssStyleObject) => typeof cssStyleObject[CSS_VALUE] == "object"
        );
        const directFilter = Object.entries(cssStyleObject).filter(
          (cssStyleObject) => typeof cssStyleObject[CSS_VALUE] != "object"
        );

        const directStyle = directFilter
          .map(([key, value]) => [toKebab(key), ":", value, ";"].join(""))
          .join("");

        const pseudoStyle = pseudoFilter.map(([key, value]) =>
          [key, "{", toString(key, value), "}"].join("")
        );

        // This do nothing, avoid lsp linting, not used variable
        key;

        return [directStyle, pseudoStyle].join("");
      };

      return [queryName, "{", toString("", cssStyleObject), "}"].join("");
    };

    const getStyle = () => {

      if (elements.length) return elementMethods;

      return elementStyle
    };

    const setStyle = (cssStyleObject, queryName) => {
      const randomClassID = UniqueID({ letters: 5, numbers: 5 });

      if (queryName === undefined) {
        styleSheet.append(Stylis(`.${css(
          randomClassID,
          isFunctionInstance(cssStyleObject)
            ? cssStyleObject()
            : cssStyleObject)}`
        ));

        if (element) {
          element.setAttribute(
            "class",
            `${randomClassID} ${element.className && element.className}`
          );

        } else if (elements.length) {
          elements.forEach(element => {
            element.setAttribute(
              "class",
              `${randomClassID} ${element.className && element.className}`
            );
          })
        }

      } else {
        styleSheet.append(Stylis(`${css(
          queryName,
          isFunctionInstance(cssStyleObject)
            ? cssStyleObject()
            : cssStyleObject)}`
        ));

        if (element) {
          if (element.className.includes(cleanQueryPunctuation(queryName))) {
            element.setAttribute("class", `${element.className && element.className}`);
          } else {
            const existingQueryName =  element.className && element.className;
            const trimQueryName = `${existingQueryName} ${cleanQueryPunctuation(queryName)} `
            element.setAttribute(
              queryName[0] === "#" ? "id" : "class",
              trimQueryName.trim(),
            );
          }
        } else if (elements.length) {

          if (elements[0].className.includes(cleanQueryPunctuation(queryName))) {
            elements.forEach(element => {
              element.setAttribute(
                "class",
                `${randomClassID} ${element.className && element.className} `
              );
            })
          } else {
            elements.forEach(element = (element) => {
              element.setAttribute(
                "class",
                `${element.className && element.className} ${cleanQueryPunctuation(queryName)} `
              );
            });
          }
        }
      }

      htmlHead.appendChild(styleSheet);

      if (isFunctionInstance(cssStyleObject)) {
        elementStyle = { ...elementStyle, ...cssStyleObject() };
        return elementMethods;
      }

      elementStyle = { ...elementStyle, ...cssStyleObject };
      return elementMethods;
    };


    const setInlineStyle = (elementInlineStyle) => {
      elementInlineStyle(element);

      return elementMethods;
    };

    const setRootCSS = (cssStyleObject) => {

      if (elements.length) return elementMethods;

      if (element.tagName.toLowerCase() === "body") {
        styleSheet.prepend(css(":root", cssStyleObject));
        htmlHead.appendChild(styleSheet);
      }

      return elementMethods;
    };

    const addEvent = (event, eventCallback, eventOptions) => {
      element.addEventListener(event, eventCallback, eventOptions);

      return elementMethods;

    };

    const init = () => {

      if (elements.length) return elements;

      return element;
    };

    elementMethods = {
      setWatcher,
      getWatchers,
      elementWatchers,
      createElement,
      queryElement,
      setInnerText,
      appendChildren,
      append,
      appendChild,
      prependChildren,
      prepend,
      prependChild,
      getClass,
      setClass,
      addClass,
      getID,
      setID,
      setAttribute,
      getAttribute,
      removeClass,
      getStyle,
      setStyle,
      setInlineStyle,
      setRootCSS,
      addEvent,
      init,
    };

    return elementMethods;
  };
}

export default Element();
