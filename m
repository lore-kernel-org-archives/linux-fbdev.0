From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 12 Feb 2010 02:51:45 +0000
Subject: Re: [PATCH 00/02] sh: Panning fixes
Message-Id: <aec7e5c31002111851x1feb7e2fl201b4197704a389@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AB12B32E73474741A2C5361C433A44DE0178367D@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
In-Reply-To: <AB12B32E73474741A2C5361C433A44DE0178367D@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Phil,

On Thu, Feb 11, 2010 at 7:23 PM, Phil Edworthy
<Phil.Edworthy@renesas.com> wrote:
> sh: Panning fixes
>
> [PATCH 01/02] sh: Add wait for vsync
> [PATCH 02/02] sh: Fix panning
>
> These patches add wait for vsync and fix the panning
> so that apps can just do ioctl(FBIOPAN_DISPLAY) followed
> by ioctl(FBIO_WAITFORVSYNC) in order to ensure that the
> pan has happened.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---

Thanks for your patches. Please make sure that the SYS panel case with
deferred io is working. Migo-R is a good board to test this on.

Cheers,

/ magnus
