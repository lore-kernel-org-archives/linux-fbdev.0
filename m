From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Wed, 27 Oct 2004 12:52:56 -0700
Sender: linuxconsole-dev-admin@lists.sourceforge.net
Message-ID: <417F9A28.3690.3FE4ECFC@localhost>
References: <417E9E3D.573.3C0CDE1A@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linuxconsole-dev-admin@lists.sourceforge.net>
In-reply-to: <417F8269.2070307@grupopie.com>
Content-description: Mail message body
Errors-To: linuxconsole-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxconsole-dev>,
	<mailto:linuxconsole-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linuxconsole-dev@lists.sourceforge.net>
List-Help: <mailto:linuxconsole-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxconsole-dev>,
	<mailto:linuxconsole-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linuxconsole-dev>
Content-Type: text/plain; charset="us-ascii"
To: Paulo Marques <pmarques@grupopie.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linuxconsole-dev@lists.sourceforge.net

Paulo Marques <pmarques@grupopie.com> wrote:

> One other thing, is there a simple way to test the emulator? I've
> been careful with the changes I did not to change the resulting
> behaviour of the emulator, but I can not _absolutely_ sure that I
> didn't break anything. It would be very good to try the emulator
> in a controlled environment. 

Unfortunately the test code I wrote years ago is only for Open Watcom and 
uses inline assembler. It hasn't been used for some time and I am not 
sure if it works properly or not (I don't think it does right now). Plus 
we recently found out that it doesn't test everything, just the 
implementation of prim_ops.c.

The only real way to test the emulator is to use it to emulate some code. 
We don't have any code we use on a regular basis to test it, but perhaps 
we should think about building a test suite for it. Usually we test it on 
Video BIOS ROM's, but that is painful because you have to switch video 
cards all the time.

XFree86 and X.org do use the same code so it could be tested there, but 
once again it is only used for Video BIOS ROM stuff. 

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
