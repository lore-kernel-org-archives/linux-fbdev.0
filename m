From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] [BK fbdev updates]
Date: Thu, 7 Nov 2002 14:18:17 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.33.0211071416290.3204-100000@maxwell.earthlink.net>
References: <1036312836.615.15.camel@daplas>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1036312836.615.15.camel@daplas>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Adding update_var to fbcon_switch fixes #1 and #2 for me.  Attached is a
> diff.

Patch applied :-)

> Also, using fbset to change video modes corrupts the console.  Looking
> at the code, the flow of control is from the console to fbdev only?  Is
> this correct?  I agree with this, it's saner.

Yes this is correct. In the next set of changes you will be able to set
the VC size via stty. You can change the resolution of the display via
/dev/fb but ideally after a close it will reset the VC original mode.
