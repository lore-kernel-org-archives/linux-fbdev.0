Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC2A313547
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Jan 2026 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421705; cv=none; b=TM00rFFzz0EZQN9VMm+nksPrC3PY7vCUbrRfQjTrvHdcgVUf9O/9ajl10uMUKZ89CeRoSYY+L0qO1mGWPR5DSZpQppWfLVZteqOLLXEFqyvzDg7w1lYhQ7IBb6BPnKqnHbAmZrElH/f1tJeEc4Os0zqlwAEjhJmLux7uPiWuYec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421705; c=relaxed/simple;
	bh=43yr8MpN9iodHfijPTJPG/VmdfqUrAFfZZhPG6ooPF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izOhXH5jD/JOr5oaHLxf/uwDR0EwNj69wohyIBy8u2FdPi2QtY12KN5JKtkMPzh/HG3yamvDVFhWIKOwCSzcqwRoOlAmLciU4dcPL+2vTeYDN5Lpv563bEvZKzlWWU7v/k6jIlrRRbjxEHqoBzgS/yQtjBNUg9leZZszblGwl/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cljO8j/8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5zfe0Vri; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cljO8j/8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5zfe0Vri; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cljO8j/8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5zfe0Vri";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cljO8j/8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5zfe0Vri"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 364995BD33;
	Mon, 26 Jan 2026 10:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769421702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MCTdo2kIuXkq/O+r27x3Hh0LuKAl+WTC23OqrDgITkw=;
	b=cljO8j/8EFltCww+6LA4PQioVmV1kZ24qISLcMlQ1R4+oKVIs6u2ZmxsGNZxm0wbrnWmJc
	/0xHbb0rUdRMJP23432mzG+TsljCjO2mhmgZYhIy27riu+XbLiG/2HpwbUWxRYlIwY+lJO
	Lat3/RIqVnJ9gCwstEY1lQB4FUopFbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769421702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MCTdo2kIuXkq/O+r27x3Hh0LuKAl+WTC23OqrDgITkw=;
	b=5zfe0Vrivp1KUobBZc8loxmLM8CZbDcNlCtgNxVSIEkj3G0A0X+r52dpv+gHd7aACx9RiA
	bGLwZTnUn5xrBbAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769421702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MCTdo2kIuXkq/O+r27x3Hh0LuKAl+WTC23OqrDgITkw=;
	b=cljO8j/8EFltCww+6LA4PQioVmV1kZ24qISLcMlQ1R4+oKVIs6u2ZmxsGNZxm0wbrnWmJc
	/0xHbb0rUdRMJP23432mzG+TsljCjO2mhmgZYhIy27riu+XbLiG/2HpwbUWxRYlIwY+lJO
	Lat3/RIqVnJ9gCwstEY1lQB4FUopFbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769421702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MCTdo2kIuXkq/O+r27x3Hh0LuKAl+WTC23OqrDgITkw=;
	b=5zfe0Vrivp1KUobBZc8loxmLM8CZbDcNlCtgNxVSIEkj3G0A0X+r52dpv+gHd7aACx9RiA
	bGLwZTnUn5xrBbAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FB7C139F0;
	Mon, 26 Jan 2026 10:01:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gWo8FIU7d2k1fQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 26 Jan 2026 10:01:41 +0000
Message-ID: <ed48e82a-cb94-477f-83c4-b2d87ae3cde6@suse.de>
Date: Mon, 26 Jan 2026 11:01:40 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 v1 0/4] [RUST] Framebuffer driver support
To: pengfuyuan <pengfuyuan@kylinos.cn>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>,
 Hans de Goede <hansg@kernel.org>, Lee Jones <lee@kernel.org>,
 Sam Ravnborg <sam@ravnborg.org>, Zsolt Kajtar <soci@c64.rulez.org>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20260126081744.781392-1-pengfuyuan@kylinos.cn>
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
In-Reply-To: <20260126081744.781392-1-pengfuyuan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de,protonmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,garyguo.net,protonmail.com,kernel.org,umich.edu,linuxfoundation.org,ffwll.ch,gmx.de,ravnborg.org,c64.rulez.org,linux.intel.com,vger.kernel.org,lists.freedesktop.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Level: 
X-Spam-Flag: NO

Hi

Am 26.01.26 um 09:17 schrieb pengfuyuan:
> This patch series adds Rust bindings and safe abstractions for the Linux
> framebuffer subsystem, enabling framebuffer drivers to be implemented in Rust.

The framebuffer subsystem is obsolete and has been deprecated for a 
decade. No new drivers accepted. Anything that really wants fbdev 
already has a driver. Can we please let it die?

Best regards
Thomas

>
> The series consists of 4 patches:
>
> 1. rust: io: mem: add ioremap_wc support
>     Adds write-combining memory mapping support to the Rust iomem abstraction,
>     which is essential for framebuffer memory regions that benefit from
>     write-combining semantics.
>
> 2. rust: device: add platdata accessors
>     Implements generic accessors for platform data, enabling drivers to access
>     platform-provided configuration. This is needed for framebuffer drivers
>     that use platform data for configuration.
>
> 3. rust: fb: add framebuffer driver support
>     Adds the core framebuffer framework abstraction, including:
>     - Device abstraction (`fb::Device`) with reference counting via `AlwaysRefCounted`
>     - Driver and Operations traits (`fb::Driver`, `fb::Operations`)
>     - Screen information wrappers (`fb::FixScreenInfo`, `fb::VarScreenInfo`)
>     - I/O operation helpers (`fb_io_read`, `fb_io_write`, `fb_io_mmap`)
>     - Blit operation helpers (`cfb_fillrect`, `cfb_copyarea`, `cfb_imageblit`)
>
> 4. rust: fb: add simplefb test driver
>     Adds a test driver that validates the framebuffer framework by porting
>     the C simplefb driver to Rust. This driver serves as both a validation
>     tool and a reference implementation for future Rust framebuffer drivers.
>
> The implementation follows the same patterns established in the DRM subsystem
> and maintains full compatibility with the existing C framebuffer subsystem.
> All C callbacks are properly bridged to Rust trait methods via the `Operations`
> trait, memory safety is ensured through proper use of `Opaque<fb_info>`, `ARef`,
> and `AlwaysRefCounted` for reference counting, type invariants are documented
> and enforced through the type system, and resource cleanup is handled via RAII
> with proper cleanup order.
>
> Testing:
> --------
> This series has been tested on:
> - ARM64 platforms with various display configurations
> - AMD RX550 graphics card
> - Moore Threads S30 graphics card
> - Multiple other graphics cards
>
> All tested configurations show normal display functionality with proper
> framebuffer initialization, rendering operations (including I/O, color register
> management, and blitting), memory mapping, and resource cleanup. The simplefb
> test driver successfully demonstrates the usage of all framebuffer framework
> APIs and validates the abstraction's correctness.
>
> The simplefb test driver serves as both a validation tool and a reference
> implementation for future Rust framebuffer drivers.
>
>
> pengfuyuan (4):
>    rust: io: mem: add ioremap_wc support
>    rust: device: add platdata accessors
>    rust: fb: add framebuffer driver support
>    rust: fb: add simplefb test driver
>
>   drivers/video/fbdev/Kconfig          |  21 +
>   drivers/video/fbdev/Makefile         |   1 +
>   drivers/video/fbdev/simplefb_rust.rs | 653 +++++++++++++++++++++++++++
>   rust/bindings/bindings_helper.h      |   2 +
>   rust/helpers/device.c                |   5 +
>   rust/helpers/io.c                    |   5 +
>   rust/kernel/device.rs                |  31 ++
>   rust/kernel/fb/blit.rs               | 106 +++++
>   rust/kernel/fb/device.rs             | 463 +++++++++++++++++++
>   rust/kernel/fb/driver.rs             | 169 +++++++
>   rust/kernel/fb/io.rs                 |  76 ++++
>   rust/kernel/fb/mod.rs                |  23 +
>   rust/kernel/fb/screeninfo.rs         | 318 +++++++++++++
>   rust/kernel/io/mem.rs                |  71 +++
>   rust/kernel/lib.rs                   |   2 +
>   15 files changed, 1946 insertions(+)
>   create mode 100644 drivers/video/fbdev/simplefb_rust.rs
>   create mode 100644 rust/kernel/fb/blit.rs
>   create mode 100644 rust/kernel/fb/device.rs
>   create mode 100644 rust/kernel/fb/driver.rs
>   create mode 100644 rust/kernel/fb/io.rs
>   create mode 100644 rust/kernel/fb/mod.rs
>   create mode 100644 rust/kernel/fb/screeninfo.rs
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


