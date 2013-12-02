From: Cliff Brake <cliff.brake@gmail.com>
Date: Mon, 02 Dec 2013 18:19:51 +0000
Subject: Re: kernel mode splash screen
Message-Id: <CAOd_LFx3Q9pV_XUXy2Pw-89B0utfXEcS9eSbUNr2JqFZoMOxqA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Aug 6, 2013 at 12:15 PM, Cliff Brake <cliff.brake@gmail.com> wrote:
> Hello,
>
> We are working on an embedded system where we need immediate feedback
> on the screen in response to power button events, etc.  We also need
> to be able to display the splash screen whenever kernel is running.
> User space splash screens get killed too early on shutdown, etc.
>
> Does anyone know of a kernel mode splash screen that will:
>
> 1) display an image
> 2) display status messages
> 3) display progress bar (nice to have, but not required)
> 4) can be accessed from kernel and user space
> 5) when enabled, will disable writes from user space
> 6) FB based

I'm currently porting
http://git.yoctoproject.org/cgit/cgit.cgi/psplash/ to the linux
kernel.  So far, its going fairly well.  Psplash is fairly clean and
minimal.  Two questions:

1) is there kernel function to write pixels to the framebuffer?  I've
been looking at fb_fillrect()

2) what is the format of the color parameter in the following data
structure (gets passed to fb_fillrect():

struct fb_fillrect {
__u32 dx; /* screen-relative */
__u32 dy;
__u32 width;
__u32 height;
__u32 color;
__u32 rop;
};

3) We are using the omap2 frame buffer driver.  By default its
configured to provide 3 frame-buffers.  I'm not sure what this means,
but I thinking that perhaps we can use one for the splash screen, and
one for the normal frame buffer used by userspace?  The issue is I
want to disable user space from drawing to the framebuffer instantly,
and switch to the splash screen when the user presses the power switch
(instant feedback).  What is the purpose of multiple frame buffers,
and is this a reasonable use of them?

Thanks,
Cliff


-- 
========http://bec-systems.com
