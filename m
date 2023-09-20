Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CC2CE79AE
	for <linux-fbdev@archiver.kernel.org>; Wed, 20 Sep 2023 08:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjITICV (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 20 Sep 2023 04:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjITICT (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 20 Sep 2023 04:02:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFE7CE
        for <linux-fbdev@vger.kernel.org>; Wed, 20 Sep 2023 01:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695196893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rnpCpoK1Qphye/H0at9y+THlkxPvcEo2r5PdFTxqnHY=;
        b=RoQH+KrP3GG6ewXQrWr3WFoLXf1EWfyL/eBaK6S0xBNZzrIecy3OYF0PpB5gQlHgz7ordC
        u0lM8+n8BFB6DpsNcV49R2QRIRshUFv6OtvZLnGNueOi+QYlbJH6YC45PyHDsJioRYZv8w
        FR1IuyagYmqdcbjPZAx/RJhXDSG1/Dw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-2rmD0CtEMFGqInKdGEo7lg-1; Wed, 20 Sep 2023 04:01:29 -0400
X-MC-Unique: 2rmD0CtEMFGqInKdGEo7lg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32001e60fb3so231182f8f.1
        for <linux-fbdev@vger.kernel.org>; Wed, 20 Sep 2023 01:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695196888; x=1695801688;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rnpCpoK1Qphye/H0at9y+THlkxPvcEo2r5PdFTxqnHY=;
        b=U+kkelwV4akX6LQod3Wp0TdXOm4AfOBIOHmPoSnY97rwZ4UTQ+hppLjqWV57T5Dy2V
         2PetDRItTpb3pdm+0axVZST+OVauC3wzY042EF6NEQFitVUJVnEP6V+A64M2Uf9nT35D
         aAO9kqbDvcU+hchkrDhmBi2y8L3Xh1d/uju2YkjTONE3UrCRB9rIDcGSbfLmxdzUz5F2
         z1KTpDhjHJPyD3NiyMJCxM93qhi53yGlyjflXQNS+Pwja9Hy4BMXMqaIeJ+aZynhZ02w
         tB1Mv+GiXRAlVzW8gvWLT4o/eWRuOLknXNtWljrndw3BH7SWTKMOfG/dzWt7qJCSxqUw
         n1UA==
X-Gm-Message-State: AOJu0YzlJwGMJIGgle8qRImRNUsoT+C81OhCFlzM6wjWszAv34/397aG
        AJGyC1Yd94wZLjsvrF+Cv9ede/ULtmR7cdA6mUpe8uI5Z1Nh8O/AJFPspR1p8/w5DKQZluZ5bR1
        J8/29xLe/D+ZsB0nSdEoW1ZY=
X-Received: by 2002:a5d:4691:0:b0:317:6579:2b9f with SMTP id u17-20020a5d4691000000b0031765792b9fmr1441900wrq.30.1695196888609;
        Wed, 20 Sep 2023 01:01:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGjMaHCrb95S6OjzxI7LM9YzqMZD+FHo9V0ilc7E6hmphf8oly7XaHzjchfvY6rdHHetD1Jw==
X-Received: by 2002:a5d:4691:0:b0:317:6579:2b9f with SMTP id u17-20020a5d4691000000b0031765792b9fmr1441876wrq.30.1695196888277;
        Wed, 20 Sep 2023 01:01:28 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id a4-20020adffb84000000b0031c5e9c2ed7sm17627845wrr.92.2023.09.20.01.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 01:01:27 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, arnd@arndb.de,
        deller@gmx.de
Cc:     linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-m68k@lists.linux-m68k.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 1/5] fbdev: Avoid file argument in fb_pgprotect()
In-Reply-To: <20230912135050.17155-2-tzimmermann@suse.de>
References: <20230912135050.17155-1-tzimmermann@suse.de>
 <20230912135050.17155-2-tzimmermann@suse.de>
Date:   Wed, 20 Sep 2023 10:01:27 +0200
Message-ID: <87il85l1d4.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Only PowerPC's fb_pgprotect() needs the file argument, although
> the implementation does not use it. Pass NULL to the internal

Can you please mention the function that's the implementation for
PowerPC ? If I'm looking at the code correctly, that function is
phys_mem_access_prot() defined in the arch/powerpc/mm/mem.c file:

pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
			      unsigned long size, pgprot_t vma_prot)
{
	if (ppc_md.phys_mem_access_prot)
		return ppc_md.phys_mem_access_prot(file, pfn, size, vma_prot);

	if (!page_is_ram(pfn))
		vma_prot = pgprot_noncached(vma_prot);

	return vma_prot;
}

and if set, ppc_md.phys_mem_access_prot is pci_phys_mem_access_prot()
that is defined in the arch/powerpc/kernel/pci-common.c source file:

https://elixir.bootlin.com/linux/v6.6-rc2/source/arch/powerpc/kernel/pci-common.c#L524

That function indeed doesn't use the file argument. So your patch looks
correct to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

