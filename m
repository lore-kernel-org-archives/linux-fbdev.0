Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D89FC07545
	for <linux-fbdev@archiver.kernel.org>; Tue, 24 Oct 2023 09:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjJXJmk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 24 Oct 2023 05:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbjJXJmi (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 24 Oct 2023 05:42:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E42510C3
        for <linux-fbdev@vger.kernel.org>; Tue, 24 Oct 2023 02:42:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9D0C433C8;
        Tue, 24 Oct 2023 09:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698140556;
        bh=QjXGnxtmyNJKXPp8tZ3P48eKB8+3bqonJw+CTu1bC+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i5meVQgrzpsMwLI2RJsygH/8mGKOBovLuHJiUmILZL2YaNe1o1Cc6n1YvPHFobxoz
         lWEhITWWOUypPxN/81nMVcKpxWiuEUIfixAMgkXxwhKeqzAtG/MNWLp/Zx9xvIdrRf
         FkLFr66I9OuYTUyNAFo+SzhUnMX4XvkP4uJoCkm3bxAQQr7Mz1PQlUnvw4PT26+I1n
         gnaEyClBSc2kZLN9m2JaS9ccs2MbW6kSvJ0dZnydUZ5KCfxIB/w1s78V3V/MPqooU9
         Z1GabSC8wPyLA9IwLFmv+hsPsLys1Sq9+vM/HyNiz0/CWcWX1gVkAZ23nwVzIIpkZU
         rV4DPpNN1XG5A==
Date:   Mon, 23 Oct 2023 12:09:36 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-fbdev@vger.kernel.org, Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@linux.ie>, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, Jon Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 0/2] fbdev/simplefb: Add missing simple-framebuffer
 features
Message-ID: <45ggpbow7usira6hqyelygyuf2lezbngdyecfk27fvukrlnyjk@rh7we3gszj5r>
References: <20231011143809.1108034-1-thierry.reding@gmail.com>
 <hrfj43uaoozwbm6wqvpbnqp2axqubuuu4rlantbmmrbddtitq5@6u6y7jibmpfg>
 <87wmvjovlk.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87wmvjovlk.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

On Thu, Oct 19, 2023 at 10:38:31AM +0200, Javier Martinez Canillas wrote:
> Maxime Ripard <mripard@kernel.org> writes:
> > On Wed, Oct 11, 2023 at 04:38:07PM +0200, Thierry Reding wrote:
> >> From: Thierry Reding <treding@nvidia.com>
> >> This contains two patches that bring simplefb up to feature parity with
> >> simpledrm. The patches add support for the "memory-region" property th=
at
> >> provides an alternative to the "reg" property to describe the memory
> >> used for the framebuffer and allow attaching the simple-framebuffer
> >> device to one or more generic power domains to make sure they aren't
> >> turned off during the boot process and take down the display
> >> configuration.
> >
> > I just talked with Sima about it in the hallway at XDC. I'm fine with
> > those patches in principle, but it looks to me that simpledrm doesn't
> > have support for power domains and we'll want that :)
> >
>=20
> It has support since commit 61df9ca23107 ("drm/simpledrm: Add support for
> multiple "power-domains") AFAIK.

Ah, my bad I didn't look in drm-misc-next

All good then, thanks!
Maxime
