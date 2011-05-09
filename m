From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Mon, 09 May 2011 07:03:54 +0000
Subject: Re: [RFC][PATCH 0/3] MERAM support for LCDC
Message-Id: <4DC791DA.4010802@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1301369758-18394-1-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1301369758-18394-1-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Magnus,

> Please add Runtime PM support to the MERAM driver. The MSTP113 bit of
> SMSTPCR1 should be dynamically controlled using pm_runtime_get_sync()
> and pm_runtime_put_sync().

So one thing that I noticed while adding in the runtime PM support is
that the MERAM bit in RMSTPCR1 seems to be enabled as a power on default
on the chip. (I determined this by dumping the register from u-boot and
poking around in the u-boot code to verify that u-boot doesn't seem to
be enabling this).

Even if pm_runtime_get_sync() and pm_runtime_put_sync() correctly enable
and disable the SMSTPCR1, with the RMSTPCR1 enabled, the clock doesn't
actually turn off.

While I still think that its a good idea to add the
pm_runtime_get_sync() and pm_runtime_put_sync() calls to do their thing
on the SMSTPCR1 side, with the current configuration we won't actually
be saving any power.

Damian
