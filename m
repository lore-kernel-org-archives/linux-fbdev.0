From: Andrew Morton <akpm@osdl.org>
Subject: Re: Radeon framebuffer weirdness in -mm2
Date: Thu, 20 Jan 2005 20:05:30 -0800
Message-ID: <20050120200530.4d5871f9.akpm@osdl.org>
References: <20050120232122.GF3867@waste.org>
	<20050120153921.11d7c4fa.akpm@osdl.org>
	<20050120234844.GF12076@waste.org>
	<20050120160123.14f13ca6.akpm@osdl.org>
	<20050121035758.GH12076@waste.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262255AbVAUEGB@vger.kernel.org>
In-Reply-To: <20050121035758.GH12076@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, benh@kernel.crashing.org

Matt Mackall <mpm@selenic.com> wrote:
>
> Here are the symptoms:
> 
>  mm2: corruption of Tux logo at boot, corruption of display at
>  powerdown, lockup and LCD blooming on next warm boot when radeonfb
>  starts. Ben suggested I try some radeonfb options, but none seemed to
>  have any effect.
> 
>  mm1: no observed problems
> 
>  mm2 - above patches: corruption still occurs but no lockup on next
>  warm boot.

So we have multiple bugs?

Next suspects would be:

+cleanup-vc-array-access.patch
+remove-console_macrosh.patch
+merge-vt_struct-into-vc_data.patch
