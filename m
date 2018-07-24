From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Jul 2018 15:24:40 +0000
Subject: Re: [PATCH] video/console/vgacon: Print big fat warning with nomodeset
Message-Id: <2310317.6avsyZ3xgb@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180702210516epcas3p151aefd4a0217c4cd30143147f0bafe1d@epcas3p1.samsung.com>
 <20180702210442.18648-1-lyude@redhat.com>
In-Reply-To: <20180702210442.18648-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lyude Paul <lyude@redhat.com>
Cc: linux-fbdev@vger.kernel.org, Kees Cook <keescook@chromium.org>, Jan =?ISO-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>

On Monday, July 02, 2018 05:04:40 PM Lyude Paul wrote:
> It's been a pretty good while since kernel modesetting was introduced.
> It has almost entirely replaced previous solutions which required
> userspace modesetting, and I can't even recall any drivers off the top
> of my head for modern day hardware that don't only support one or the
> other. Even nvidia's ugly blob does not require the use of nomodeset,
> and only requires that nouveau be blacklisted.
> 
> Effectively, the only thing nomodeset does in the year 2018 is disable
> your graphics drivers. Since VESA is a thing, this will give many users
> the false impression that they've actually fixed an issue they were
> having with their machine simply because the laptop will boot up to a
> degraded GUI. This of course, is never actually the case.
> 
> Things get even worse when you consider that there's still an enormous
> amount of tutorials users find on the internet that still suggest adding
> nomodeset, along with various users who have been around long enough to
> still suggest it.
> 
> There really isn't any legitimate reason I can see for this to be an
> option that's used by anyone else other then developers, or properly
> informed users. So, let's end the confusion and start printing warnings
> whenever it's enabled.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

