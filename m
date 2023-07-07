Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAFBC001DC
	for <linux-fbdev@archiver.kernel.org>; Fri,  7 Jul 2023 13:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjGGNlh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 7 Jul 2023 09:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjGGNl1 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 7 Jul 2023 09:41:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6CD2117
        for <linux-fbdev@vger.kernel.org>; Fri,  7 Jul 2023 06:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688737228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eSLQOQX2Flx1G07KYazrMVvBAcWU6hFPEM6DlSyIig8=;
        b=DVGtyuEM762jj5CVQrl//Q0olWHpiQA9QUCIFCSEIgehNX53s2Y4DUa6R31XOXse6jMynW
        sXcqEBJLs7rXxSOPmjyJuaq3XvTcjOQ+q0+QvrpGdXEb2xVtRJhYx0O5JNQO0pgrdZwW9l
        7waU2YFTYzKBaOLjoEsex3rl3Qvf9k8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-5Ga_WDznNuqWdC7bgrFxeQ-1; Fri, 07 Jul 2023 09:40:24 -0400
X-MC-Unique: 5Ga_WDznNuqWdC7bgrFxeQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-2f2981b8364so968088f8f.1
        for <linux-fbdev@vger.kernel.org>; Fri, 07 Jul 2023 06:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688737223; x=1691329223;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eSLQOQX2Flx1G07KYazrMVvBAcWU6hFPEM6DlSyIig8=;
        b=gzZlxAuR+QuOLXr2/nz1YR46MZdmFSZ9K5Oa5KXr012Fibeca5NcdYHRbanmpimBRF
         rFPJX8aC879UN6JbybiUKtMqxsUuLFc/CqbBjK+xEmpObWv0mV3j0swf8BJK0X6UDYAg
         zKHOfzMv6ttHTAyEzaKt6ujWHsuvaPwP+0VzurJ3wo+pSjoIyK+xizqBbR49gRjtBKGm
         GReC5syTX84c+HA11iKy1OoVh0lV0RfjY+MQL2Vnl926R3JfN8iv1ZJXGUgnXZv21hFU
         tzEvjjfYyD4o40n3aHSKC0x26Jc9R8x+BZA3/yL6N8bmuZdPrapv8fNcCt3HEDcyqCsY
         LiFw==
X-Gm-Message-State: ABy/qLYFq2uku9PB1Mc896iU0xX/4+6X2OFkggsmSTvEmz30U2yySt1+
        JEXZwtRLijFfwW5sqC1iCTgGFdYU0dgxpX0I1+rVK3mGzX3OeEY90iRJpMsD1cSbJAQoqHULSKB
        TRsqrIcoeVFHSso2/g82E3h8=
X-Received: by 2002:adf:fd84:0:b0:314:2c7a:d100 with SMTP id d4-20020adffd84000000b003142c7ad100mr3491318wrr.42.1688737223528;
        Fri, 07 Jul 2023 06:40:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGembFVs9w4+Nx6kwExMzgs9gyKSxG86BN2Jn1gUhGo+dJC0cQ0C5x3R9/Olki3X8v+sW6RJQ==
X-Received: by 2002:adf:fd84:0:b0:314:2c7a:d100 with SMTP id d4-20020adffd84000000b003142c7ad100mr3491295wrr.42.1688737223237;
        Fri, 07 Jul 2023 06:40:23 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d60c4000000b003112ab916cdsm4482161wrt.73.2023.07.07.06.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 06:40:23 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, Ard Biesheuvel <ardb@kernel.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/4] vgacon: rework screen_info #ifdef checks
In-Reply-To: <20230707095415.1449376-2-arnd@kernel.org>
References: <20230707095415.1449376-1-arnd@kernel.org>
 <20230707095415.1449376-2-arnd@kernel.org>
Date:   Fri, 07 Jul 2023 15:40:22 +0200
Message-ID: <87jzvbyh4p.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> On non-x86 architectures, the screen_info variable is generally only
> used for the VGA console where supported, and in some cases the EFI
> framebuffer or vga16fb.
>
> Now that we have a definite list of which architectures actually use it
> for what, use consistent #ifdef checks so the global variable is only
> defined when it is actually used on those architectures.
>
> On powerpc, there is no support for vgacon, but there is support for
> vga16fb. Loongarch and riscv have no support for vgacon or vga16fb, but
> they support EFI firmware, so only that needs to be checked, and the
> initialization can be removed because that is handled by EFI.
> IA64 has both vgacon and EFI.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

[...]

> diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
> index 5a55ac82c13a4..0c09ff7fde46b 100644
> --- a/arch/ia64/kernel/setup.c
> +++ b/arch/ia64/kernel/setup.c
> @@ -86,9 +86,11 @@ EXPORT_SYMBOL(local_per_cpu_offset);
>  #endif
>  unsigned long ia64_cycles_per_usec;
>  struct ia64_boot_param *ia64_boot_param;
> +#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_EFI)
>  struct screen_info screen_info;

I think that only screen_info should be guarded by both symbols ?

>  unsigned long vga_console_iobase;

It seems this variable was never used since it was introduced by commit
66b7f8a30437 ("[IA64-SGI] pcdp: add PCDP pci interface support") ?

>  unsigned long vga_console_membase;

And this is only used by mdacon (not supported by ia64), vgacon and
vga16fb (not supported by ia64 either).

So this could just be guarded just by CONFIG_VGA_CONSOLE for ia64 ?

The rest of the patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

