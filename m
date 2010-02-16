From: Jaya Kumar <jayakumar.lkml@gmail.com>
Date: Tue, 16 Feb 2010 01:30:58 +0000
Subject: Re: [PATCH 01/02] sh: Add wait for vsync
Message-Id: <45a44e481002151730l7e78837cn17889b16d34618f5@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AB12B32E73474741A2C5361C433A44DE0178367F@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
In-Reply-To: <AB12B32E73474741A2C5361C433A44DE0178367F@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Feb 12, 2010 at 4:18 PM, Ian Armstrong <mail01@iarmst.co.uk> wrote:
>
> I would question the original definition for FBIO_WAITFORVSYNC. I get the
> impression that it originated with the matrox driver, but other drivers have
> since implemented the same ioctl and each has an identical define. Would the
> proper fix be to get the definition into fb.h and use it from there. It's
> already defined in multiple places (ps3fb.h, intelfb.h, atyfb_base.c,
> ivtvfb.h, matroxfb.h) and exported to userspace more than once.
>

Hi Ian, fbdev folks,

Yes, I think the fbdev and vsync concept needs an update. I have an
API I would like to propose. It is still early and I would like to
make it sufficiently generic so that it can meet the needs of at least
the following types of hardware:
A- those that expose a vertical retrace counter
B- those that support generating an interrupt at the start of the
vertical blanking period
C- those controllers for displays that do not have a concept of
vertical retrace (ie: non-volatile/bistable displays)

The api would look like (from userspace):

fb_wait_vsync(int div, int rem, unsigned int *count);

Internally, that would lead to an ioctl and drivers would be able to
provide an fbops for their specific implementation. The implementation
would do something along the following lines for each hardware type:
A- put the calling process to sleep until (retrace_counter % div =
rem). This will let vissim apps achieve their desired level of
granularity.
B- put the calling process to sleep until the vblank interrupt is
received plus calculated offset using timing and pixclock, returning
the calculated value for the count.
C- put the calling process to sleep until the most recent display
update is completed, returning 0 for the count and ignoring div, rem.

Let me know if this concept looks satisfactory.

Thanks,
jaya
