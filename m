From: Jun Nie <niej0001@gmail.com>
Subject: Re: [PATCH 3/6] pxa: fix pxa168 lcd controller vsync/hsync timing 
	error
Date: Thu, 5 Nov 2009 10:15:32 +0800
Message-ID: <7c34ac520911041815k6555e209r4039ae9f97c9ebca@mail.gmail.com>
References: <7c34ac520911022245x7f002a7at846a835dfded550c@mail.gmail.com>
	<f17812d70911032320k379dc7laab1979a3b452969@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <f17812d70911032320k379dc7laab1979a3b452969@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org

2009/11/4 Eric Miao <eric.y.miao@gmail.com>:
> On Tue, Nov 3, 2009 at 2:45 PM, Jun Nie <niej0001@gmail.com> wrote:
>> pxa: fix pxa168 lcd controller vsync/hsync timing error
>>
>> Signed-off-by: Jun Nie <njun@marvell.com>
>> ---
>> =A0drivers/video/pxa168fb.c | =A0 =A04 ++--
>> =A0include/video/pxa168fb.h | =A0 =A02 --
>> =A02 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
>> index 2ba1444..bdd524c 100644
>> --- a/drivers/video/pxa168fb.c
>> +++ b/drivers/video/pxa168fb.c
>> @@ -459,8 +459,8 @@ static void set_dumb_panel_control(struct fb_info *i=
nfo)
>> =A0 =A0 =A0 =A0x |=3D mi->invert_composite_blank ? 0x00000040 : 0;
>> =A0 =A0 =A0 =A0x |=3D (info->var.sync & FB_SYNC_COMP_HIGH_ACT) ? 0x00000=
020 : 0;
>> =A0 =A0 =A0 =A0x |=3D mi->invert_pix_val_ena ? 0x00000010 : 0;
>> - =A0 =A0 =A0 x |=3D (info->var.sync & FB_SYNC_VERT_HIGH_ACT) ? 0 : 0x00=
000008;
>> - =A0 =A0 =A0 x |=3D (info->var.sync & FB_SYNC_HOR_HIGH_ACT) ? 0 : 0x000=
00004;
>> + =A0 =A0 =A0 x |=3D (info->var.sync & FB_SYNC_VERT_HIGH_ACT) ? 0x000000=
08 : 0;
>> + =A0 =A0 =A0 x |=3D (info->var.sync & FB_SYNC_HOR_HIGH_ACT) ? 0x0000000=
4 : 0;
>
> Hi Jun,
>
> Could you please help double check this? My understanding is
> FB_SYNC_VERT_HIGH_ACT means it's a positive pulse covering all the
> valid HSYNCs, and a rising edge of VSYNC means a start of the frame.
>
> However, CFG_INV_VSYNC is '1' means the opposite.
>

My understanding is that high active means high level trigger new
frame/line. Below page support my point if it is not wrong.

http://www.arcadecollecting.com/info/Sync_fixing.txt

Jun
