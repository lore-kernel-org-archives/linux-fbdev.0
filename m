Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491E823E32D
	for <linux-fbdev@vger.kernel.org>; Thu,  5 Mar 2026 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772703082; cv=none; b=nBtNUG9pqr4OjpPzZq6mLWQRocH2o+WaKD6lYNqrS5uJQz46MHIesLampuegYs2+qGmcVCe+fKxtUuINlG2Ae8DPd01qQ5IVR5xWzAk+qkEdXpcb6LOvd68FegwBhaXcRJElOw69G1fxqyovPpudE+1Qh6U5yhKgHywaRP9i5+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772703082; c=relaxed/simple;
	bh=GfJNa7Lf8cvl6UiWnslnSBofiruFLBl7dyDrRR45cUU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=EMOX2IhIIhNKNFLKFpS8VdzH6WhrRe981PdUQP+uq66RCj/G3lJZskVNDzLiercd0ZE/L+rxU3SwTNLAMjVqZ3XCu7J4+wkJGT/zEkByTmOveqInlwlhyGzOe7fIMPBoufY4hGbRpiErcEk+B1cuPXxVM62Y0M4hPmDNrjMLNbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d2M3AqsL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2ocHZxwC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d2M3AqsL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2ocHZxwC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d2M3AqsL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2ocHZxwC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d2M3AqsL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2ocHZxwC"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 21CA53E7E6;
	Thu,  5 Mar 2026 09:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772703074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rTg6qS7C3FW1ka7WMv9vqXCZ3GoNrJDCFvsGyy76xY8=;
	b=d2M3AqsLkbTTrbV+NueiAntOS8vP+pHAUtlAqL5+Jto+z8hzekperstLhFXQQ2zQUFmt9m
	fVSQBTAzVX7CSAHcq10hIldJtTp80aqaIwnThGA8kCmDPUT9IVrk2zJxz18WmV7Ps09sXr
	98C/TGH9WfpjU0k7RraTvMY0yNjbi80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772703074;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rTg6qS7C3FW1ka7WMv9vqXCZ3GoNrJDCFvsGyy76xY8=;
	b=2ocHZxwCEMroRIejEFwz3bmH8L4mMBpen/tDSnDkNohotYiWQpRZiBbuPL2ZeHQeWrLK1j
	pwxQxQUxvlBnhlCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772703074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rTg6qS7C3FW1ka7WMv9vqXCZ3GoNrJDCFvsGyy76xY8=;
	b=d2M3AqsLkbTTrbV+NueiAntOS8vP+pHAUtlAqL5+Jto+z8hzekperstLhFXQQ2zQUFmt9m
	fVSQBTAzVX7CSAHcq10hIldJtTp80aqaIwnThGA8kCmDPUT9IVrk2zJxz18WmV7Ps09sXr
	98C/TGH9WfpjU0k7RraTvMY0yNjbi80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772703074;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rTg6qS7C3FW1ka7WMv9vqXCZ3GoNrJDCFvsGyy76xY8=;
	b=2ocHZxwCEMroRIejEFwz3bmH8L4mMBpen/tDSnDkNohotYiWQpRZiBbuPL2ZeHQeWrLK1j
	pwxQxQUxvlBnhlCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D856E3EA68;
	Thu,  5 Mar 2026 09:31:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9XDqMmFNqWmPMAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 05 Mar 2026 09:31:13 +0000
Content-Type: multipart/mixed; boundary="------------oBsQCzO0CgXyYuWwgkoM6yyj"
Message-ID: <4acb921b-6bce-4bbf-a607-cc3e991dfc3a@suse.de>
Date: Thu, 5 Mar 2026 10:31:13 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/13] lib/fonts: Compare font data for equality with
 font_data_is_equal()
To: Nathan Chancellor <nathan@kernel.org>
Cc: gregkh@linuxfoundation.org, deller@gmx.de, sam@ravnborg.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260302141255.518657-1-tzimmermann@suse.de>
 <20260302141255.518657-10-tzimmermann@suse.de>
 <20260305002347.GA4102761@ax162>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20260305002347.GA4102761@ax162>
X-Spamd-Result: default: False [-3.20 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MIME_BASE64_TEXT(0.10)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmx.de,ravnborg.org,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_ALL(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.com:url,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.20
X-Spam-Level: 

This is a multi-part message in MIME format.
--------------oBsQCzO0CgXyYuWwgkoM6yyj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi

Am 05.03.26 um 01:23 schrieb Nathan Chancellor:
[...]
>>   
>> +static bool font_data_is_internal(font_data_t *fd)
>> +{
>> +	return is_kernel_rodata((unsigned long)fd);
>> +}
>> +
[...]
>>
>> This breaks the build when CONFIG_FONT_SUPPORT is a module.
>>
>>    $ cat allno.config
>>    CONFIG_MODULES=y
>>    CONFIG_DRM=m
>>    CONFIG_DRM_PANIC=y
>>
>>    $ make -skj"$(nproc)" ARCH=x86_64 CROSS_COMPILE=x86_64-linux- KCONFIG_ALLCONFIG=1 allnoconfig all
>>    ERROR: modpost: "__end_rodata" [lib/fonts/font.ko] undefined!
>>    make[4]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
>>    ...
>>
>>    $ scripts/config -s FONT_SUPPORT
>>    m

Thanks for testing. The attached patch fixes the problem for me. Could 
you please test?

Best regards
Thomas

>>
>> Cheers,
>> Nathan
>>
>>
>> +	if (font_data_size(lhs) != font_data_size(rhs))
>> +		return false;
>> +	if (FNTSUM(lhs) && FNTSUM(rhs) && FNTSUM(lhs) != FNTSUM(rhs))
>> +		return false;
>> +
>> +	return !memcmp(lhs, rhs, FNTSIZE(lhs));
>> +}
>> +EXPORT_SYMBOL_GPL(font_data_is_equal);
>> +
>>   /*
>>    * Font lookup
>>    */
>> -- 
>> 2.53.0
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


--------------oBsQCzO0CgXyYuWwgkoM6yyj
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-test-for-internal-fonts-by-refcount.patch"
Content-Disposition: attachment;
 filename="0001-test-for-internal-fonts-by-refcount.patch"
Content-Transfer-Encoding: base64

RnJvbSA4ZGM0OGQyZTY3NmQxNDM3NTg0Nzk0ZjRkZjNkZDIwZDA4ODc4NjU1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5A
c3VzZS5kZT4KRGF0ZTogVGh1LCA1IE1hciAyMDI2IDA5OjI4OjI4ICswMTAwClN1YmplY3Q6
IFtQQVRDSF0gdGVzdCBmb3IgaW50ZXJuYWwgZm9udHMgYnkgcmVmY291bnQKCkludGVybmFs
IGZvbnQgZGF0YSBpcyAnc3RhdGljIGNvbnN0Jy4gSGVuY2UgdGVzdCBhZ2FpbnN0IHRoZSBy
ZWZjb3VudApiZWluZyB6ZXJvLgotLS0KIGxpYi9mb250cy9mb250cy5jIHwgNSArLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2xpYi9mb250cy9mb250cy5jIGIvbGliL2ZvbnRzL2ZvbnRzLmMKaW5kZXggMTk4
YWFlODY5YmUyLi5iNzNkNzRiOTc3ZWMgMTAwNjQ0Ci0tLSBhL2xpYi9mb250cy9mb250cy5j
CisrKyBiL2xpYi9mb250cy9mb250cy5jCkBAIC00NSwxNCArNDUsMTEgQEAgc3RhdGljIHN0
cnVjdCBmb250X2RhdGEgKnRvX2ZvbnRfZGF0YV9zdHJ1Y3QoZm9udF9kYXRhX3QgKmZkKQog
CiBzdGF0aWMgYm9vbCBmb250X2RhdGFfaXNfaW50ZXJuYWwoZm9udF9kYXRhX3QgKmZkKQog
ewotCXJldHVybiBpc19rZXJuZWxfcm9kYXRhKCh1bnNpZ25lZCBsb25nKWZkKTsKKwlyZXR1
cm4gIVJFRkNPVU5UKGZkKTsgLyogaW50ZXJuYWwgZm9udHMgaGF2ZSBubyByZWZlcmVuY2Ug
Y291bnRpbmcgKi8KIH0KIAogc3RhdGljIHZvaWQgZm9udF9kYXRhX2ZyZWUoZm9udF9kYXRh
X3QgKmZkKQogewotCWlmIChXQVJOX09OKGZvbnRfZGF0YV9pc19pbnRlcm5hbChmZCkpKQot
CQlyZXR1cm47Ci0KIAlrZnJlZSh0b19mb250X2RhdGFfc3RydWN0KGZkKSk7CiB9CiAKLS0g
CjIuNTMuMAoK

--------------oBsQCzO0CgXyYuWwgkoM6yyj--
