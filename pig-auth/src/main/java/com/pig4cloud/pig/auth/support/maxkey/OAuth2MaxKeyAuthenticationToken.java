package com.pig4cloud.pig.auth.support.maxkey;

import com.pig4cloud.pig.auth.support.base.OAuth2ResourceOwnerBaseAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.AuthorizationGrantType;

import java.util.Map;
import java.util.Set;


public class OAuth2MaxKeyAuthenticationToken extends OAuth2ResourceOwnerBaseAuthenticationToken {

	public OAuth2MaxKeyAuthenticationToken(AuthorizationGrantType authorizationGrantType,
                                           Authentication clientPrincipal, Set<String> scopes, Map<String, Object> additionalParameters) {
		super(authorizationGrantType, clientPrincipal, scopes, additionalParameters);
	}

}
