From: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Fri, 15 Oct 2004 13:48:27 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1097848107l.20759l.0l@hh>
References: <416E6ADC.3007.294DF20D@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CISMI-0004JT-7s
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Oct 2004 06:43:02 -0700
Received: from hermine.aitel.hist.no ([158.38.50.15])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CISM7-0005WP-Uj
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Oct 2004 06:43:02 -0700
In-Reply-To: <416E6ADC.3007.294DF20D@localhost> (from
	KendallB@scitechsoft.com on Thu Oct 14 21:02:36 2004)
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; delsp="Yes"; format="Flowed"
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, penguinppc-team@lists.penguinppc.org

On 14-10-2004 21:02:36, Kendall Bennett wrote:
> Hello All,
[...]
> So what we would like to find out is how much interest there might be
> in
> both an updated VESA framebuffer console driver as well as the code
> for
> the Video card BOOT process being contributed to the maintstream
> kernel.

The BOOT stuff is very interesting.  Currently, both my videocards
(in the same pc)
have nice hw-specific framebuffer drivers, but they require that
the card is initialized by the bios first and this only ever
happens to one of the cards.  Xfree _can_ do the job, but way
too late for setting up the framebuffer device.

> If there is interest, we would start out by first contributing the
> core
> emulator and Video BOOT code, and then work on building a better VESA
> framebuffer console driver.

Having video BOOT would be great, and please make it independent
of the framebuffer drivers.  I might want to try your vesa driver,
but I might also want to use the hw-accelerated chip specific driver
that happens to need an initialized video card.

Helge Hafting




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
