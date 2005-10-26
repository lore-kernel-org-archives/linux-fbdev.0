From: "Hasjim Williams" <hasjim.williams@futaris.org>
Subject: Linux 2.6 fbcon rotation - in software
Date: Wed, 26 Oct 2005 14:38:47 +1000
Message-ID: <1130301527.27554.246030407@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <openzaurus-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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
To: openzaurus-devel@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net

Hi all,

I am looking to rotate the framebuffer console on an embedded ARM
device.  I know that both OPIE and GPE (X Windows) support screen
rotation in software.  I think they use a shadow framebuffer...  Has
anyone on either of the lists started implementing this in 2.6.x ???  I
know the Zaurus CL-3xxx series use the pxafb driver and fbcon is rotated
on these devices.  My platform uses the amba_clcd driver and fbcon is
also rotated on this device.

See http://sourceforge.net/mailarchive/message.php?msg_id=12904686 for
the Zaurus info.

Is there some easy / good way to add rotated console support to the
kernel?  Or do we have to use a shadow framebuffer?

Thanks for any help / suggestions ...


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
