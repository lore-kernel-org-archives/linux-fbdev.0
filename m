From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 17 Jun 2013 16:19:26 +0000
Subject: Re: [PATCH] video: of_display_timing.h: Include <video/display_timing.h>
Message-Id: <CAOMZO5ANwzAebau2jQniWwdPaLta5ZtQ--XRxYuxHL0A=9QVjQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1371476589-4660-1-git-send-email-fabio.estevam@freescale.com>
In-Reply-To: <1371476589-4660-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Jun 17, 2013 at 1:09 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 10:43 Mon 17 Jun     , Fabio Estevam wrote:
>> Commit ffa3fd21de ("videomode: implement public of_get_display_timing()") causes
>> the following build warning:
>>
>> include/video/of_display_timing.h:18:10: warning: 'struct display_timing' declared inside parameter list [enabled by default]
>> include/video/of_display_timing.h:18:10: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
>>
>> As 'struct display_timing' is defined at <video/display_timing.h>, let's include
>> this header to avoid the warning.
> for 3.10 or 3.11?

This is 3.11 material.
