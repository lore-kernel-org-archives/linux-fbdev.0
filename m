From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: Confused about atyfb status.
Date: Sat, 17 Jan 2004 13:03:13 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200401171303.13802.alex.kern@gmx.de>
References: <20040117063816.87535.qmail@web14913.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AhpTC-0003JD-Gn
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 17 Jan 2004 04:22:30 -0800
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AhpTB-0006e7-VP
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 17 Jan 2004 04:22:30 -0800
In-Reply-To: <20040117063816.87535.qmail@web14913.mail.yahoo.com>
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
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

Am Samstag, 17. Januar 2004 07:38 schrieb Jon Smirl:
> There is a fairly advanced one here: http://www.saftware.de/
> but I don't know it's current status.
>
> --- Richard Smith <rsmith@bitworks.com> wrote:
> > I'm trying to use the atyfb on a Rage Mobility M1 but I'm confused on
> > which source tree has the best chance of getting to work.
> >
> > Grepping through both the 2.4.24 and 2.6.1rc3 tree I find that the
> > 2.4.24 tree has several references to a mobility M1 in the comments.
> >
> > The 2.6.1rc3 tree does not.
> >
> > Neither tree however has an entry for my device.  Neither will detect my
> > device which has an id of 0x4c52.
> >
> > If I copy one of the "3D RAGE Mobility" id lines and change the clocks
> > to what I think they should be the device gets detected but various
> > specifications (like ammount and type of RAM) are incorrect.
> >
> > So if I am about to start hacking on a tree to figure out whats wrong
> > what tree should I use?  Where is the most advanced tree for the atyfb
> > located?
> >
> >
> > --
> > Richard A. Smith
> > rsmith@bitworks.com

Mach64 MOBILITY M1 works by me for ages. I submitted all patches to James for 
months. They are in fbdev.diff.gz. But I dont think, they will be merged with 
vanilla very soon.

Regards
Alex Kern



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
