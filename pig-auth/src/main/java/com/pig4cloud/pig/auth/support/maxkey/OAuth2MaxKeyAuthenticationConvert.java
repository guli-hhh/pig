package com.pig4cloud.pig.auth.support.maxkey;

import com.pig4cloud.pig.auth.support.base.OAuth2ResourceOwnerBaseAuthenticationConverter;
import com.pig4cloud.pig.common.security.util.OAuth2EndpointUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.AuthorizationGrantType;
import org.springframework.security.oauth2.core.OAuth2ErrorCodes;
import org.springframework.security.oauth2.core.endpoint.OAuth2AuthorizationResponseType;
import org.springframework.security.oauth2.core.endpoint.OAuth2ParameterNames;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;
import java.util.Set;

public class OAuth2MaxKeyAuthenticationConvert extends OAuth2ResourceOwnerBaseAuthenticationConverter<OAuth2MaxKeyAuthenticationToken> {

	@Override
	public boolean support(String grantType) {
		System.out.println(grantType);
		return OAuth2AuthorizationResponseType.CODE.getValue().equals(grantType);
	}

	@Override
	public OAuth2MaxKeyAuthenticationToken buildToken(Authentication clientPrincipal, Set<String> requestedScopes, Map<String, Object> additionalParameters) {
		return new OAuth2MaxKeyAuthenticationToken(new AuthorizationGrantType(OAuth2AuthorizationResponseType.CODE.getValue()), clientPrincipal, requestedScopes, additionalParameters);
	}

	@Override
	public void checkParams(HttpServletRequest request) {
		MultiValueMap<String, String> parameters = OAuth2EndpointUtils.getParameters(request);
		String code = parameters.getFirst(OAuth2ParameterNames.CODE);
		if (!StringUtils.hasText(code) || parameters.get(OAuth2ParameterNames.CODE).size() != 1) {
			OAuth2EndpointUtils.throwError(OAuth2ErrorCodes.INVALID_REQUEST, OAuth2ParameterNames.CODE,
					OAuth2EndpointUtils.ACCESS_TOKEN_REQUEST_ERROR_URI);
		}
	}
}
