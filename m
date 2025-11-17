Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01171DF27D
	for <linux-fbdev@vger.kernel.org>; Mon, 17 Nov 2025 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763392492; cv=none; b=j9VL0O6RgJ5s+efDTJbJdALhtvru8BZB2kJtafZHYCauRwpbiDLtnAr7ce4F9wMrW/uZj1QFYC3wk8rx61ASFOVuqdgnJKNfrStQbc9cII/Pvwhuj2GMYvfs1A22d2LVYvlO1Ep5RHfg6v9+35elTCXC4/tuyqkH3qBICRMgkKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763392492; c=relaxed/simple;
	bh=Kpxw0TaZ10Ycx/CK4jHHAsvhr5KNMqub3z5v5EbOBwc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PF2SUBf4623S6cDp9kxtsPkYMuzsQIHSZn8M7INhFVNVGgwGOUsjTEgjE4K8+kDTSM0iRcThqIxO7cWEsjmmKhIe0rFgFMCVkB+c/KXI//fm26qUJ6AzjV9KI4dhACM5tG0GXs60K0ORo9JCrWJl6yB2y0dQkoGZx9/Uhg/s6Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+ysXdVy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lageWxIh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+ysXdVy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lageWxIh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763392490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kx8ZUuPVQ5znIDs7P4S73XyxKgfUqqBlKv9cHIMA/P0=;
	b=f+ysXdVyRjJFiO+UYXtD3qgVZafU7GJGDJ+TNBaljAA//5elf5H5utPYvQDaS+ZmuqT/wT
	G1sCzKF/C4KIXWCAD78f3R3gjF0AdtE9H6izmwwV+2axljX7hyItVhsn2Gw9T7lw+SzwnD
	qvS/reG6Fe5HPNkhDRkC94miizNWCMM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-a9TQRDWBMJu1oOnmRiac1A-1; Mon, 17 Nov 2025 10:14:47 -0500
X-MC-Unique: a9TQRDWBMJu1oOnmRiac1A-1
X-Mimecast-MFC-AGG-ID: a9TQRDWBMJu1oOnmRiac1A_1763392486
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429cdb0706aso3952852f8f.0
        for <linux-fbdev@vger.kernel.org>; Mon, 17 Nov 2025 07:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763392486; x=1763997286; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kx8ZUuPVQ5znIDs7P4S73XyxKgfUqqBlKv9cHIMA/P0=;
        b=lageWxIhLoq262ri6AMN6vroKxQNOZX2AXzEU7pbrDCsUkgcsJF9lrAbqY5mkNic5I
         yxL8uwIqZMDel4YMbx0+/KGukLaLoGxe5VIt8Trp8Sn9+VN9HBj6uNHm06uMUaZTj1Ee
         wBfpYIGWao+CqsMLKuaZUbldUh5lOYE3cbFnNZXam1G7TkM1aQR4XgbPSu8mOnRIIq2l
         ovbH4iqMZBG27Pd9azYDxoov3TlH1c0d3w1cQHiy93ZrFQxqqsPhLxulq0Cn0J/P4Yll
         QnXSF+7I8i2vzz3K7+EsbQc7paApqX5SxYCFi8P6lJg5pPozBH3kh64ezjn47WFxiHrQ
         rh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763392486; x=1763997286;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kx8ZUuPVQ5znIDs7P4S73XyxKgfUqqBlKv9cHIMA/P0=;
        b=cfrgLWZPFaqbvDu2VC990W0+dcCAVMfa0+5vksOcigOl8mtg3e1rRlm5/x+7NDiQDp
         +fz6pIIGTCacFxP/uxLnmInA2p7KdtZZGqvD8XStsMG0bav8MXdRiyo5LJlyguSk5DU+
         sL6STy2sk9I9hvRgq+18lYGRXtCvaoUs6LYvSp/wUTkbVt/Ws6W9qmgBHYO12MEJre26
         OFKVZGwJHBqMzWekCBgNDcQpyEWzW4Ni6DeYilg13LvbznOhNugCb8iWHuFrm9xt2P4g
         q3UechoFwvGY20HHnHbZ3JNUw3yceQoko9kM9C/Sqc0W5iTM0ux5nJiRDs0KYBtm3iRm
         YYsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTCvcdrVvlyBqIUBRHjonEOJmJ66OB2HbWQdsmF6Om52xihxTcbvDC6iEQ3m7a4+1svIRZc1OZJO6gLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg5/CXWswxE3AEGcB9ZP7ujK1VpG8Nvyq2KXlYa1y/9IgH+FWO
	DPNN8lCSMNoBc8J2t34GImOoE5sZhZCryGix+Aq1haLy/BWHgGgKU4mxWUN4VteeCKtJDdlE8Bh
	Ty1AU1JBjuMVdHe/VnECf+l5ec0cIxPhJCtCEK6Z2b45/98OChyBn0ftBSUeFN8d+
X-Gm-Gg: ASbGncvbkt/tqbenWpUfJ0eYhTZXg7yUB6pGrdayJYfFZKBK8si4PzvFTv66cKRymGE
	SV6xGzTQaFnwtKPOhKCFDn1fuL8GYYQalmDs9qEd1ZqlkgRw9w+zqTtle0rHPJxUPGS9th4PuGH
	2R5wj0911oKOERFd1/HXP7/2L+FtNwXGZsyZXUbAdoNRB4uCnwnNLfNYT8CRMQvFoQdxSuDMcBC
	+7XrVjBEVYmdnsqtVF5JuyYpQ8p09z52r3WvZYiqK5nNykWsE+U6LQCw4fL+BDXVXhjl6RBM61G
	mrzd1UPDOV8zUJaUaAKpIVet/qCq5vtwQiTY2WKl7SgsyJnXhk9KMDHrmbm8YXuujk+v0ZlVAP/
	pFc1tr+C5sXas0BnyE3og61BrkMScOGxW36idKMvwpetb/Tnh505puo9qbqzUvHBltJKX
X-Received: by 2002:a05:600c:8b4b:b0:477:755b:5587 with SMTP id 5b1f17b1804b1-4778fe55405mr135076645e9.8.1763392486522;
        Mon, 17 Nov 2025 07:14:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1Imhn+5hGc5232CXEsbuOoPXvPaiufKMMUFle9A3qt/AF8KRLMNtNt270jXisxDN8USi6Ng==
X-Received: by 2002:a05:600c:8b4b:b0:477:755b:5587 with SMTP id 5b1f17b1804b1-4778fe55405mr135076405e9.8.1763392486109;
        Mon, 17 Nov 2025 07:14:46 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e2bcf9sm313765805e9.3.2025.11.17.07.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 07:14:45 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, deller@gmx.de, lukas@wunner.de,
 ville.syrjala@linux.intel.com, sam@ravnborg.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] drm, fbcon, vga_switcheroo: Avoid race condition in
 fbcon setup
In-Reply-To: <9306d41f-6afc-4277-9198-a23e51cbd9f6@suse.de>
References: <20251105161549.98836-1-tzimmermann@suse.de>
 <87fradkkzp.fsf@ocarina.mail-host-address-is-not-set>
 <9306d41f-6afc-4277-9198-a23e51cbd9f6@suse.de>
Date: Mon, 17 Nov 2025 16:14:44 +0100
Message-ID: <87cy5glmhn.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi
>
> Am 17.11.25 um 11:32 schrieb Javier Martinez Canillas:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>>
>> Hello Thomas,
>>
>>> Protect vga_switcheroo_client_fb_set() with console lock. Avoids OOB
>>> access in fbcon_remap_all(). Without holding the console lock the call
>>> races with switching outputs.
>>>
>>> VGA switcheroo calls fbcon_remap_all() when switching clients. The fbcon
>>> function uses struct fb_info.node, which is set by register_framebuffer().
>>> As the fb-helper code currently sets up VGA switcheroo before registering
>>> the framebuffer, the value of node is -1 and therefore not a legal value.
>>> For example, fbcon uses the value within set_con2fb_map() [1] as an index
>>> into an array.
>>>
>>> Moving vga_switcheroo_client_fb_set() after register_framebuffer() can
>>> result in VGA switching that does not switch fbcon correctly.
>>>
>>> Therefore move vga_switcheroo_client_fb_set() under fbcon_fb_registered(),
>>> which already holds the console lock. Fbdev calls fbcon_fb_registered()
>>> from within register_framebuffer(). Serializes the helper with VGA
>>> switcheroo's call to fbcon_remap_all().
>>>
>>> Although vga_switcheroo_client_fb_set() takes an instance of struct fb_info
>>> as parameter, it really only needs the contained fbcon state. Moving the
>>> call to fbcon initialization is therefore cleaner than before. Only amdgpu,
>>> i915, nouveau and radeon support vga_switcheroo. For all other drivers,
>>> this change does nothing.
>>>
>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> Link: https://elixir.bootlin.com/linux/v6.17/source/drivers/video/fbdev/core/fbcon.c#L2942 # [1]
>>> ---
>> I'm not that familiar with fbcon and vga_switcheroo to properly review
>> your patch but after reading the explanation in the commit message and
>> reading the diff, the change does make sense to me.
>>
>> Acked-by: Javier Martinez Canillas <javierm@redhat.com>
>>
>> But I think that would be good if you get some testing for the drivers
>> that make use of vga_switcheroo. Also, do you need a Fixes tag ?
>
> I've ran the testing on amdgpu and i915 so that nothing breaks. The bug 
> is hard to reproduce though. I've discovered it by reading the code.
>

Thanks.

I usually put that kind of information between the --- separator and the
start of the diff. Since that info can be useful for reviewers and doesn't
end in the commited patch, due tools like `git am` omitting that section.

> About Fixes, the problem has been in the code forever. So IDK what Fixes 
> would make sense. Just in case:
>

I see. Then I agree that having the tag is less useful.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

