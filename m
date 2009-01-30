From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: Re: using the metronome on a different platform
Date: Fri, 30 Jan 2009 01:31:06 -0500
Message-ID: <45a44e480901292231n7873b2b0mb772957f6ff7d3fa@mail.gmail.com>
References: <4B59547A-D018-4C07-B8A9-2497082F11BC@cs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jayakumar.lkml@gmail.com>) id 1LSmuD-0000qF-E0
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 Jan 2009 06:31:09 +0000
Received: from rv-out-0708.google.com ([209.85.198.246])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LSmuC-00088H-0j for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 Jan 2009 06:31:09 +0000
Received: by rv-out-0708.google.com with SMTP id f25so308559rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 29 Jan 2009 22:31:06 -0800 (PST)
In-Reply-To: <4B59547A-D018-4C07-B8A9-2497082F11BC@cs.umd.edu>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Nicholas Chen <nchen@cs.umd.edu>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

Hi Nicholas,

On Thu, Jan 29, 2009 at 4:53 PM, Nicholas Chen <nchen@cs.umd.edu> wrote:
> Dear Jaya,
>
> I was hoping you could provide me some assistance with my effort to move the
> metronome to the gumstix overo platform.  I think the main issue is that I'm

Very interesting. The overo's OMAP cpu should make a huge improvement
in performance over the pxa255 cpu in the gumstix basix in am200. I
wish I had one! :-)

> not quite sure what the expected behavior on the standard am200 platform is,
> as I don't have an am200 around.
>
> From my reading of the am200epd code, when the am200epd module gets loaded,
> it attempts to install the metronomefb module with request_module. Does this
> mean that on a correct run metronomefb should be visible if I lsmod without
> having the separately modprobe the metronomefb?

Ok, yes, your reading of the code is right and if depmod and stuff is
correct, it should autoload. But you say "the am200epd module" and the
version of am200epd in the 2.6.28 tree is only buildable as a builtin.
This is because it has to use set_pxa_fb_info. Can you let me know
which version of the kernel you are using and any other patches that
you think might be relevant?

>
> At the moment, I think I have successfully modified the am200epd.c to work
> with the overo's framebuffer device (i see /dev/fb0 with the right
> dimensions and the output frequencies on the clock pins are checking out).

Very good. btw, please post this code to the list. I think it could
help others who are interested in metronomefb on different platforms.

> However, I don't think the metronomefb device is being loaded. A manual
> modprobe of the metronomefb after i get to the command line segfaults
> because the load_waveform function call cannot be resolved(?) -- does this
> have something to do with it being marked __devinit?

That sounds very unexpected to me because load_waveform is inside
metronomefb and is called only at probe time which is also __devinit
so there's no issue that I'm aware of in that area. Could you enable
debug and then post the output of the error message and any build
warnings.

>
> Thanks in advance for any assistance you can provide,

My pleasure. I'm happy to help but keep in mind I'm just a volunteer
so I am very slow sometimes.

Thanks,
jaya

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
