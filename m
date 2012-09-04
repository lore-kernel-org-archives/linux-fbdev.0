From: Zhou Zhu <zzhu84@gmail.com>
Date: Tue, 04 Sep 2012 02:55:52 +0000
Subject: Re: [PATCHv2 1/4] video: mmp display subsystem
Message-Id: <CAJATT-6xGeX5jhyRn=XRpZSNuzB6wz09nWK22YSxTOFLhTrX-w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1346293222-13692-1-git-send-email-zzhu3@marvell.com>
In-Reply-To: <1346293222-13692-1-git-send-email-zzhu3@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi, Florian,

Would you please help to review my patches?
Also would you please help to apply them if no more issue.
Thank you very much!

On Thu, Aug 30, 2012 at 10:20 AM, Zhou Zhu <zzhu3@marvell.com> wrote:
> Added mmp display subsystem to support Marvell MMP display controllers.
>
> This subsystem contains 4 parts:
> --fb folder
> --core.c
> --hw folder
> --panel folder
>
> 1. fb folder contains implementation of fb.
> fb get path and ovly from common interface and operates on these structures.
>
> 2. core.c provides common interface for a hardware abstraction.
> Major parts of this interface are:
> a) Path: path is a output device connected to a panel or HDMI TV.
> Main operations of the path is set/get timing/output color.
> fb operates output device through path structure.
> b) Ovly: Ovly is a buffer shown on the path.
> Ovly describes frame buffer and its source/destination size, offset, input
> color, buffer address, z-order, and so on.
> Each fb device maps to one ovly.
>
> 3. hw folder contains implementation of hardware operations defined by core.c.
> It registers paths for fb use.
>
> 4. panel folder contains implementation of panels.
> It's connected to path. Panel drivers would also regiester panels and linked
> to path when probe.
>
> Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
> Signed-off-by: Lisa Du <cldu@marvell.com>

-- 
Thanks,
-Zhou
