package com.pig4cloud.pig.auth.support.maxkey;

import cn.hutool.extra.spring.SpringUtil;
import com.pig4cloud.pig.auth.support.base.OAuth2ResourceOwnerBaseAuthenticationProvider;
import com.pig4cloud.pig.auth.support.sms.OAuth2ResourceOwnerSmsAuthenticationToken;
import com.pig4cloud.pig.common.core.constant.SecurityConstants;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.oauth2.core.AuthorizationGrantType;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.OAuth2ErrorCodes;
import org.springframework.security.oauth2.core.OAuth2Token;
import org.springframework.security.oauth2.core.endpoint.OAuth2ParameterNames;
import org.springframework.security.oauth2.server.authorization.OAuth2AuthorizationService;
import org.springframework.security.oauth2.server.authorization.client.RegisteredClient;
import org.springframework.security.oauth2.server.authorization.token.OAuth2TokenGenerator;

import javax.annotation.Resource;
import java.util.Map;

public class OAuth2MaxKeyAuthenticationProvider extends OAuth2ResourceOwnerBaseAuthenticationProvider<OAuth2MaxKeyAuthenticationToken> implements AuthenticationProvider {


	private static final Logger LOGGER = LogManager.getLogger(OAuth2MaxKeyAuthenticationProvider.class);


	/**
	 * Constructs an {@code OAuth2AuthorizationCodeAuthenticationProvider} using the
	 * provided parameters.
	 *
	 * @param authenticationManager
	 * @param authorizationService  the authorization service
	 * @param tokenGenerator        the token generator
	 * @since 0.2.3
	 */
	public OAuth2MaxKeyAuthenticationProvider(AuthenticationManager authenticationManager, OAuth2AuthorizationService authorizationService, OAuth2TokenGenerator<? extends OAuth2Token> tokenGenerator) {
		super(authenticationManager, authorizationService, SpringUtil.getBean("maxKeyOAuth2TokenGenerator"));
	}

	@Override
	public boolean supports(Class<?> authentication) {
		boolean supports = OAuth2MaxKeyAuthenticationToken.class.isAssignableFrom(authentication);
		LOGGER.debug("supports authentication=" + authentication + " returning " + supports);
		return supports;
	}

	@Override
	public void checkClient(RegisteredClient registeredClient) {
		assert registeredClient != null;
		if (!registeredClient.getAuthorizationGrantTypes()
				.contains(AuthorizationGrantType.PASSWORD)) {
			throw new OAuth2AuthenticationException(OAuth2ErrorCodes.UNAUTHORIZED_CLIENT);
		}
	}

	@Override
	public UsernamePasswordAuthenticationToken buildToken(Map<String, Object> reqParameters) {
		String code = (String) reqParameters.get(OAuth2ParameterNames.CODE);
		return new UsernamePasswordAuthenticationToken(code, null);
	}
}
