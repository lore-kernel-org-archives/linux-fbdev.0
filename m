Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEEA35DA67
	for <linux-fbdev@vger.kernel.org>; Wed, 10 Jun 2026 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781077682; cv=none; b=pSmF+jMgJsZA7rOarytwWkhWSmeAqnpgbJH5iUhF8hYl2TjY0YHcHUy1r+s+F4OM0tACpWWwzf7D2/pbHZssNUyR25fYK/7YMtEm7FTVbJP5U7Hi7Hm4nXQiCjegqlhepgniuF1twBU/jUKePmwZAtjL8s7ZO68zRpk7INeoOfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781077682; c=relaxed/simple;
	bh=GCkiunlMztfCbm89ywoBdUoAfD271Ic0PQlAoOHL1HQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Al8aX9lRu96R1GGBr+Xdd0HztQtCgtBy6yvok3+gcfDvPs/22aJCZhDDPe5PiKU6OlZeFsvZrS8HLD54N5XGyYuWLSyx55l0givtY6oBZhk6hEDBhI/BUdWqHJcUOZFMIdF3uvz7az+sg2D77hmuq+LGlSfK2RvIj1/5/UD5RKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ebZ7mIbm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g25Ptwu2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ebZ7mIbm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g25Ptwu2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ebZ7mIbm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g25Ptwu2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ebZ7mIbm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g25Ptwu2"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B1D896A901;
	Wed, 10 Jun 2026 07:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781077679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kUX8r8j8Y1+JCkdUbznQ7a1+FIS5Vu0iuaWgATys+R8=;
	b=ebZ7mIbmnal1flsnLsKu2ecScDtKs8fhxvsZnX/Tt2SCUJpwzDD1DY/k8lglXfvR/4EQPA
	IFqdntYMjwy2bZQ9cWhuFPpXwZlSuqBREL6E/A67qy4r73MO2pr2cXdIEsTMlLj/7AHHvG
	C34mHYeWCIDtNUBrwhKJhbQpcWkww3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781077679;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kUX8r8j8Y1+JCkdUbznQ7a1+FIS5Vu0iuaWgATys+R8=;
	b=g25Ptwu2u3kWbE7yyIlxoE1cn+OEd1ckwf0huzQ3+m8KpMT7wM6RRlQKOnYbwyxZVEAPV7
	XLAmvmLvp3CrH8Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781077679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kUX8r8j8Y1+JCkdUbznQ7a1+FIS5Vu0iuaWgATys+R8=;
	b=ebZ7mIbmnal1flsnLsKu2ecScDtKs8fhxvsZnX/Tt2SCUJpwzDD1DY/k8lglXfvR/4EQPA
	IFqdntYMjwy2bZQ9cWhuFPpXwZlSuqBREL6E/A67qy4r73MO2pr2cXdIEsTMlLj/7AHHvG
	C34mHYeWCIDtNUBrwhKJhbQpcWkww3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781077679;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kUX8r8j8Y1+JCkdUbznQ7a1+FIS5Vu0iuaWgATys+R8=;
	b=g25Ptwu2u3kWbE7yyIlxoE1cn+OEd1ckwf0huzQ3+m8KpMT7wM6RRlQKOnYbwyxZVEAPV7
	XLAmvmLvp3CrH8Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97CCF779A7;
	Wed, 10 Jun 2026 07:47:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ptXQI68WKWpXVgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 10 Jun 2026 07:47:59 +0000
Message-ID: <f15b9e11-b77d-4af7-9287-233268aa2b77@suse.de>
Date: Wed, 10 Jun 2026 09:47:59 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch submission preferences: request_mem_region changes in fbdev
 drivers
To: Chintan Patel <chintanlike@gmail.com>, linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <c82b582e-2aeb-41c6-8389-25aeeaf46704@gmail.com>
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
In-Reply-To: <c82b582e-2aeb-41c6-8389-25aeeaf46704@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.de:mid]
X-Spam-Level: 
X-Spam-Score: -4.30

Hi

Am 10.06.26 um 05:58 schrieb Chintan Patel:
> Hello Thomas,
>
> I'm preparing patches to add proper memory-region requests across 
> legacy fbdev drivers (use of 
> request_mem_region/pci_request_region/devm_request_mem_region where 
> appropriate) to avoid conflicts between fbdev and DRM drivers. I’ve 
> started making changes (examples: pvr2fb.c, macfb.c, cyber2000fb.c, 
> xilinxfb.c).
>
> Before I prepare a patch series, could you please advise:
>
> Preferred format: a single combined patch or a series of smaller 
> patches? If a series, do you prefer one patch per driver file, per 
> driver family, or grouped another way?
> Any drivers or areas to exclude or treat specially (e.g., vga16fb or 
> VGA-exclusive ranges)?
> Any tests or checks you expect before posting (build, boot smoke 
> tests, Kconfig options to verify)?
> I can prepare an initial series and send it for review; I’ll follow 
> your preferred format. Thanks for guidance.

Please send one patch per driver. The rest is up to you.

Best regards
Thomas

>
> Thank you,
> Chintan Patel

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


