From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: xxx_check_var
Date: 11 Dec 2002 10:08:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1039597729.538.39.camel@zion>
References: <Pine.LNX.4.33.0212102219010.2617-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0212102219010.2617-100000@maxwell.earthlink.net>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Wed, 2002-12-11 at 07:32, James Simmons wrote:
> 
>  For the pmu_sleep_notifier can you pass in a specific struct fb_info or
> do you need to make a list of all of them?

So far, I need to make that list. But sooner or later, those notifiers
will go away and I'll use the PCI and/or new driver model PM features.

Ben.
