From: Adam Borowski <kilobyte@angband.pl>
Date: Fri, 20 Jan 2017 14:27:16 +0000
Subject: Re: [PATCH v10 3/4] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <20170120142716.aw3nqyz4dyel7rsh@angband.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201701112105.R6Zog6jw%fengguang.wu@intel.com>
 <20170113200758.9880-4-manuel.schoelling@gmx.de>
 <20170119132352.GB29998@kroah.com>
 <1484842335.1250.7.camel@gmx.de>
 <20170119163314.GD22777@kroah.com>
 <20170119230412.ekq3uhdmdvdjqoed@angband.pl>
 <20170120131611.afzupatjx4y7vcwv@angband.pl>
 <20170120133156.GA11329@kroah.com>
In-Reply-To: <20170120133156.GA11329@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Manuel =?iso-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>, jslaby@suse.com, lkml14@scotdoyle.com, rdunlap@infradead.org, shorne@gmail.com, andrey_utkin@fastmail.com, akpm@linux-foundation.org, paul.burton@imgtec.com, daniel.vetter@ffwll.ch, tj@kernel.org, hdegoede@redhat.com, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri, Jan 20, 2017 at 02:31:56PM +0100, Greg KH wrote:
> On Fri, Jan 20, 2017 at 02:16:11PM +0100, Adam Borowski wrote:
> > On Fri, Jan 20, 2017 at 12:04:12AM +0100, Adam Borowski wrote:
> > > On Thu, Jan 19, 2017 at 05:33:14PM +0100, Greg KH wrote:
> > > > I'd recommend that patch get to clear_console() first, having it use the
> > > > new escape sequence, if it isn't supported, shouldn't cause any
> > > > problems, right?
> > 
> > # Subject: Bug#845177 closed by Matthias Klose <doko@debian.org>
> > #
> > # This is an automatic notification regarding your Bug report
> > # which was filed against the bash package:
> > #
> > # #845177: clear_console: assumes VT switch clears scrollback
> > #
> > # It has been closed by Matthias Klose <doko@debian.org>.
> > [...]
> > # Changes:
> > #    * clear_console: Securely erase the current console. Closes: #845177.
> 
> This means it was accepted?  Or rejected?

Accepted.

It's in unstable (or will be in the next mirror pulse), we're at the fastest
possible moment to get stuff to the next stable release -- it'll be in
Stretch (about to freeze).  Ubuntu migration is currently open so it'll get
there soon, in time for Zesty (17.04).  Other Debian derivatives likewise
pull at their own pace.

Most distributions unrelated to Debian don't seem to ship clear_console but
I have no real idea: just checked Fedora 25, it doesn't have it in the
default install at least.


Meow!
-- 
Autotools hint: to do a zx-spectrum build on a pdp11 host, type:
  ./configure --host=zx-spectrum --build=pdp11
