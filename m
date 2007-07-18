From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev: find mode with highest
	refresh rate in fb_find_mode()
Date: Wed, 18 Jul 2007 23:18:15 +0800
Message-ID: <1184771895.4523.33.camel@daplas>
References: <20070718084102.GA22694@spock.one.pl>
	 <20070718143803.GA5787@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763763AbXGRPSb@vger.kernel.org>
In-Reply-To: <20070718143803.GA5787@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Michal Januszewski <spock@gentoo.org>, linux-kernel@vger.kernel.org, Ondrej Zajicek <santiago@crfreenet.org>

On Wed, 2007-07-18 at 16:38 +0200, Ondrej Zajicek wrote:
> On Wed, Jul 18, 2007 at 10:41:02AM +0200, Michal Januszewski wrote:
> > Currently if the refresh rate is not specified fb_find_mode() returns
> > the first known video mode with the requested resoluion, which provides
> > no guarantees wrt the refresh rate.  Change this so that the mode with
> > the highest refresh rate is returned instead.
> 
> What refresh rate it sets when used on card or monitor without DDC?

Yes, I noted this also while reviewing patches.  fb_find_mode() is used
predominantly with the 'generic' modedb which contains modes that are
not specific to the card or monitor.  And fb_try_mode() is not a
guarantee that the returned refresh rate will be safe (we have a lot of
drivers that do not check the timings against the display capabilities).

It would be best that fb_find_mode() return the safest refresh rate
(60Hz) instead of the highest.

Tony
