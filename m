From: Jon Smirl <jonsmirl@yahoo.com>
Subject: DRM and Framebuffer conflicts
Date: Thu, 23 Oct 2003 09:24:54 -0700 (PDT)
Sender: dri-devel-admin@lists.sourceforge.net
Message-ID: <20031023162454.31377.qmail@web14903.mail.yahoo.com>
References: <1066889583.643.2.camel@leguin>
Mime-Version: 1.0
Return-path: <dri-devel-admin@lists.sourceforge.net>
In-Reply-To: <1066889583.643.2.camel@leguin>
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eric Anholt <eta@lclark.edu>
Cc: DRI <dri-devel@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

--- Eric Anholt <eta@lclark.edu> wrote:
> I've converted the DRM to old-style attachment.  I haven't tested with
> radeonfb to see if it actually fixed it (netboot linux kernels are
> annoying to prepare), but my radeon and sis cards continued to work.  If
> someone could test with radeonfb and the latest DRM, that would be
> great.

I think we need to implement both the old and new schemes and fallback to the
old one if radeonfb is present. DRM also needs to add code marking resources in
use which will also conflict with framebuffer. DRM needs to mark the resources
when framebuffer isn't around to be compatible with hotplug.

It would flow something like this:
new style probe
if (new probe has device)
   mark resources in use
else
   do old style probe

The framebuffer drivers that have DRM parallels need to implement the same
code. That way it won't matter what order things get loaded.

A second possibility would be to implement a tiny stub for just attaching to
the PCI ID and resources. Then framebuffer and DRM could both share the stub.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
