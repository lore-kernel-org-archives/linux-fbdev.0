From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date: Thu, 25 Sep 2014 19:54:36 +0000
Subject: Re: [PATCH 00/27] add pm_runtime_last_busy_and_autosuspend() helper
Message-Id: <32849712.0gtj7BlKY3@vostro.rjw.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
 <20140925142201.GD28045@saruman> <20140925142758.GB1316@katana>
In-Reply-To: <20140925142758.GB1316@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>, Vinod Koul <vinod.koul@intel.com>
Cc: linux-wireless@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, patches@opensource.wolfsonmicro.com, linux-doc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Chris Ball <chris@printf.net>, dri-devel@lists.freedesktop.org, Marcin Wojtas <mw@semihalf.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Herrmann <dh.herrmann@gmail.com>, Shinya Kuribayashi <skuribay@pobox.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Jingoo Han <jg1.han@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Jani Nikula <jani.nikula@intel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Alan Stern <stern@rowland.harvard.edu>, Ben Skeggs <bskeggs@redhat.com>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, Dave Airlie <airlied@redhat.com>, Ulf Hansson <ulf.hanss>

On Thursday, September 25, 2014 04:27:58 PM Wolfram Sang wrote:
> 
> --Bn2rw/3z4jIqBvZU
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> On Thu, Sep 25, 2014 at 09:22:01AM -0500, Felipe Balbi wrote:
> > On Thu, Sep 25, 2014 at 01:27:18PM +0530, Vinod Koul wrote:
> > > On Wed, Sep 24, 2014 at 03:32:19PM -0500, Felipe Balbi wrote:
> > > > > > > OK, I guess this is as good as it gets.
> > > > > > > 
> > > > > > > What tree would you like it go through?
> > > > > > 
> > > > > > Do we really need this new helper ? I mean, the very moment when > we
> > > > > > decide to implement ->runtime_idle() we will need to get rid of t> his
> > > > > > change. I wonder if it's really valid...
> > > > > 
> > > > > I'm not sure I'm following?  This seems to simply implement what dr> ivers
> > > > > have been doing already as one function.  Why would it be invalid t> o reduce
> > > > > code duplication?
> > > > 
> > > > For two reasons:
> > > > 
> > > > 1) the helper has no inteligence whatsoever. It just calls the same
> > > > functions.
> > > > 
> > > > 2) the duplication will vanish whenever someone implements
> > > > ->runtime_idle() and have that call pm_runtime_autosuspend() (like PCI
> > > > and USB buses are doing today). This will just be yet another line th> at
> > > > needs to change.
> > > > 
> > > > Frankly though, no strong feelings, I just think it's a commit that
> > > > doesn't bring that any benefits other than looking like one line was
> > > > removed.
> > > and yes that is what it tries to do nothing more nothing less. If in fu> ture
> > > there are no users (today we have quite a few), then we can remove the > dead
> > > macro, no harm. But that is not the situation today.
> > 
> > as I said, a commit that's bound to be useless. It's not like you're
> > saving 10 lines of code, it's only one. Replacing two simple lines with
> > a function which takes <joke> almost as many characters to type </joke>.
> > 
> > IMO, this is pretty useless and I'd rather not see them in the drivers I
> > maintain, sorry.
> 
> It is not a NACK from me; yet from a high-level perspective I agree with
> Felipe.

OK

I'd rather not merge something that driver people don't want to use.

Vinod?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
