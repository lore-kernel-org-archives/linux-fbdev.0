From: Manuel =?ISO-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Date: Fri, 13 Jan 2017 20:00:34 +0000
Subject: Re: [PATCH v9 4/4] console: Make persistent scrollback a boot parameter
Message-Id: <1484337634.1720.4.camel@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4640722.jsFVORW8WM@amdc3058>
         <20170110212838.16175-5-manuel.schoelling@gmx.de>
         <20170110225846.gd2pqczplnkl74d3@angband.pl>
In-Reply-To: <20170110225846.gd2pqczplnkl74d3@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Adam Borowski <kilobyte@angband.pl>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, lkml14@scotdoyle.com, rdunlap@infradead.org, shorne@gmail.com, andrey_utkin@fastmail.com, akpm@linux-foundation.org, paul.burton@imgtec.com, daniel.vetter@ffwll.ch, tj@kernel.org, hdegoede@redhat.com, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tue, 2017-01-10 at 23:58 +0100, Adam Borowski wrote:
> On Tue, Jan 10, 2017 at 10:28:38PM +0100, Manuel Schölling wrote:
> > The impact of the persistent scrollback feature on the code size is
> > rather small, so the config option is removed. The feature stays
> > disabled by default and can be enabled by using the boot command
> > line
> > parameter 'vgacon.scrollback_persistent=1' or by setting
> > VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT=y.
> > 
> > Signed-off-by: Manuel Schölling <manuel.schoelling@gmx.de>
> > Suggested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > +module_param_named(scrollback_persistent, scrollback_persistent,
> > bool, 0000);
> > +MODULE_PARM_DESC(scrollback_persistent, "Enable persistent
> > scrollback for all vga consoles");
> 
> A command-line knob settable by the end-user is something more
> persistent
> than a config option.  As you're going to extend this code beyond
> vgacon in
> the near future, perhaps it'd be better to have a shared setting for
> all
> console drivers?
According to the guys at #kernelnewbies on IRC everybody hates new
command line options.
I'd rather stick to the module parameter for now and maybe introduce a 
new cmd line option later, once this feature has been implemented in
several console drivers.

Bye,

Manuel

