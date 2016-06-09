/**
 * Copyright (c) 2011, salesforce.com, inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided
 * that the following conditions are met:
 *
 *    Redistributions of source code must retain the above copyright notice, this list of conditions and the
 *    following disclaimer.
 *
 *    Redistributions in binary form must reproduce the above copyright notice, this list of conditions and
 *    the following disclaimer in the documentation and/or other materials provided with the distribution.
 *
 *    Neither the name of salesforce.com, inc. nor the names of its contributors may be used to endorse or
 *    promote products derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

package canvas;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.codehaus.jackson.annotate.JsonProperty;

/**
 * Describes contextual information about the current organization/company.
 */
@JsonIgnoreProperties(ignoreUnknown=true)
public class CanvasOrganizationContext {
    private String organizationId;
    private String name;
    private boolean multicurrencyEnabled;
    private String currencyISOCode;

    /**
     * The organization id of the organization.
     */
    @JsonProperty("organizationId")
    public String getOrganizationId() {
        return this.organizationId;
    }

    public void setOrganizationId(String organizationId) {
        this.organizationId = organizationId;
    }

    /**
     * The name of the company or organization.
     */
    @JsonProperty("name")
    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    /**
     * Indicates whether the user\u2019s organization uses multiple currencies (true) or not (false).
     */
    @JsonProperty("multicurrencyEnabled")
    public boolean isMulticurrencyEnabled() {
        return this.multicurrencyEnabled;
    }

    public void setMulticurrencyEnabled(boolean multicurrencyEnabled) {
        this.multicurrencyEnabled = multicurrencyEnabled;
    }

    /**
     * Current company's default currency ISO code (applies only if multi-currency is disabled for the org).
     */
    @JsonProperty("currencyIsoCode")
    public String getCurrencyISOCode() {
        return this.currencyISOCode;
    }

    public void setCurrencyISOCode(String currencyISOCode) {
        this.currencyISOCode = currencyISOCode;
    }

    @Override
    public String toString()
    {
        return organizationId + ","+
               name + ","+
               multicurrencyEnabled + ","+
               currencyISOCode;
    }
}
