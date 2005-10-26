From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: Re: [Linux-fbdev-devel] Linux 2.6 fbcon
	rotation - in software
Date: Wed, 26 Oct 2005 23:49:26 +0100
Message-ID: <1130366966.8322.57.camel@localhost.localdomain>
References: <1130301527.27554.246030407@webmail.messagingengine.com>
	 <435F6C77.7010603@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <openzaurus-devel-admin@lists.sourceforge.net>
In-Reply-To: <435F6C77.7010603@gmail.com>
Sender: openzaurus-devel-admin@lists.sourceforge.net
Errors-To: openzaurus-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openzaurus-devel>,
	<mailto:openzaurus-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:openzaurus-devel@lists.sourceforge.net>
List-Help: <mailto:openzaurus-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openzaurus-devel>,
	<mailto:openzaurus-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openzaurus-devel>
Content-Type: text/plain; charset="us-ascii"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, openzaurus-devel@lists.sourceforge.net, hasjim.williams@futaris.org

On Wed, 2005-10-26 at 19:45 +0800, Antonino A. Daplas wrote:
> Hasjim Williams wrote:
> > Hi all,
> > 
> > I am looking to rotate the framebuffer console on an embedded ARM
> > device.  I know that both OPIE and GPE (X Windows) support screen
> > rotation in software.  I think they use a shadow framebuffer...  Has
> > anyone on either of the lists started implementing this in 2.6.x ???  I
> > know the Zaurus CL-3xxx series use the pxafb driver and fbcon is rotated
> > on these devices.  My platform uses the amba_clcd driver and fbcon is
> > also rotated on this device.
> > 
> > See http://sourceforge.net/mailarchive/message.php?msg_id=12904686 for
> > the Zaurus info.
> > 
> > Is there some easy / good way to add rotated console support to the
> > kernel?  Or do we have to use a shadow framebuffer?
> 
> I had a patch that does software rotation for the framebuffer console. But
> this was during 2.5. The patch does this by having different putcs, putc,
> bmove, fill, and cursor methods depending on the orientation.
> 
> If this is really desired, I may try to revive that patch...

I was asked about this offlist and sent Hasjim a copy of the 2.5 patch. 

Console rotation would be extremely useful for several of the Zaurus
devices (Collie, Spitz, Akita and Borzoi). These use pxafb or sa1100fb
which don't support rotation in hardware. (The other Zaurus models use
w100fb which does support hardware rotation).

I've been planning to make the patch apply to recent kernels but haven't
found the time to do that yet...

Richard



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
