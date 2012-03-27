﻿/*

    Slatwall - An e-commerce plugin for Mura CMS
    Copyright (C) 2011 ten24, LLC

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
    Linking this library statically or dynamically with other modules is
    making a combined work based on this library.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.
 
    As a special exception, the copyright holders of this library give you
    permission to link this library with independent modules to produce an
    executable, regardless of the license terms of these independent
    modules, and to copy and distribute the resulting executable under
    terms of your choice, provided that you also meet, for each linked
    independent module, the terms and conditions of the license of that
    module.  An independent module is a module which is not derived from
    or based on this library.  If you modify this library, you may extend
    this exception to your version of the library, but you are not
    obligated to do so.  If you do not wish to do so, delete this
    exception statement from your version.

Notes:

*/
component displayname="Content" entityname="SlatwallContent" table="SlatwallContent" persistent="true" accessors="true" extends="BaseEntity" {
	
	// Persistent Properties
	property name="contentID" ormtype="string" length="32" fieldtype="id" generator="uuid" unsavedvalue="" default="";
	property name="title" ormtype="string";
	property name="cmsContentID" ormtype="string";
	property name="cmsContentIDPath" ormtype="string";
	property name="cmsSiteID" ormtype="string";
	property name="restrictAccessFlag" ormtype="boolean";
	property name="allowPurchaseFlag" ormtype="boolean";
	property name="requirePurchaseFlag" ormtype="boolean";
	property name="requireSubscriptionFlag" ormtype="boolean";
	property name="templateFlag" ormtype="boolean";
	property name="productListingFlag" ormtype="boolean";
	property name="defaultProductsPerPage" ormtype="integer";
	property name="showProductInSubPagesFlag" ormtype="boolean";
	property name="disableProductAssignmentFlag" ormtype="boolean";
	
	// Related Object Properties (many-to-one)
	property name="restrictedContentTemplateContent" cfc="Content" fieldtype="many-to-one" fkcolumn="restrictedContentTemplateContentID";
	
	// Related Object Properties (one-to-many)
	
	// Related Object Properties (many-to-many)
	property name="skus" singularname="sku" cfc="Sku" type="array" fieldtype="many-to-many" linktable="SlatwallSkuAccessContent" fkcolumn="contentID" inversejoincolumn="skuID" inverse="true";
	
	// Remote properties
	property name="remoteID" ormtype="string" hint="Only used when integrated with a remote system";
	
	// Audit Properties
	property name="createdDateTime" ormtype="timestamp";
	property name="createdByAccount" cfc="Account" fieldtype="many-to-one" fkcolumn="createdByAccountID";
	property name="modifiedDateTime" ormtype="timestamp";
	property name="modifiedByAccount" cfc="Account" fieldtype="many-to-one" fkcolumn="modifiedByAccountID";
	
	// Non-Persistent Properties


	public any function init() {
       // set default collections for association management methods
 	   if(isNull(variables.skus)) {
	       variables.skus = [];
	   }

       return super.init();
    }
    

	
	// ============ START: Non-Persistent Property Methods =================
	
	// ============  END:  Non-Persistent Property Methods =================
		
	// ============= START: Bidirectional Helper Methods ===================
	
	
	public void function addSku(required any sku) {
		// set this side of relationship
		if(!hasSku(arguments.sku)) {
			arrayAppend(variables.skus,arguments.sku);
		}
		// now set the other side of relationship
		if(!arguments.sku.hasAccessContent(this)) {
			arguments.sku.addAccessContent(this);
		}
	}

	public void function removeSku(required any sku) {
		// remove this side of relationship
		var index = arrayFind(variables.skus, arguments.sku);
		if(index > 0) {
			arrayDeleteAt(variables.skus, index);
		}
		// now remove the other side of relationship
		if(arguments.sku.hasAccessContent(this)) {
			arguments.sku.removeAccessContent(this);
		}
	}
	
	// =============  END:  Bidirectional Helper Methods ===================

	// ================== START: Overridden Methods ========================
	
	public string function getSimpleRepresentationPropertyName() {
		return "title";
	}
	
	// ==================  END:  Overridden Methods ========================
	
	// =================== START: ORM Event Hooks  =========================
	
	// ===================  END:  ORM Event Hooks  =========================
}