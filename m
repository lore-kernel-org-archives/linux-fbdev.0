From: Grazvydas Ignotas <notasas@gmail.com>
Date: Mon, 23 Apr 2012 15:32:54 +0000
Subject: Re: [PATCH] OMAPDSS: VENC: allow switching venc type at runtime
Message-Id: <CANOLnOPcuiD7+rqafeSTZc3GB0_C10viUZe0+XbJQ0be82qDtQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1332978312-11959-1-git-send-email-notasas@gmail.com>
	<1335183802.30659.17.camel@deskari>
In-Reply-To: <1335183802.30659.17.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Mon, Apr 23, 2012 at 3:23 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Thu, 2012-03-29 at 02:45 +0300, Grazvydas Ignotas wrote:
>> VENC type (composite/svideo) doesn't have to be fixed by board wiring,
>> it is possible to provide both connectors, which is what pandora does.
>> Having to recompile the kernel for users who have TV connector types
>> that's don't match default board setting is very inconvenient, especially
>> for users of a consumer device, so add support for switching VENC type
>> at runtime over a new sysfs file venc_type.
>>
>> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
>> ---
>>  Documentation/arm/OMAP/DSS     |    1 +
>>  drivers/video/omap2/dss/venc.c |   55 +++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 55 insertions(+), 1 deletions(-)
>>
>> diff --git a/Documentation/arm/OMAP/DSS b/Documentation/arm/OMAP/DSS
>> index 888ae7b..18e2214 100644
>> --- a/Documentation/arm/OMAP/DSS
>> +++ b/Documentation/arm/OMAP/DSS
>> @@ -156,6 +156,7 @@ timings           Display timings (pixclock,xres/hfp/hbp/hsw,yres/vfp/vbp/vsw)
>>               "pal" and "ntsc"
>>  panel_name
>>  tear_elim    Tearing elimination 0=off, 1=on
>> +venc_type    Output type (video encoder only): "composite" or "svideo"
>
> I think we could have a better name here. "venc" name is quite obscure
> on the user level. And it's not even quite correct, venc stays the same,
> it's just the output that is changed. "output_type"? "connector"?
> "connector_type"?

I'll go for output_type then, connector* associates with fixed hardware to me.
I'll take care of other comments too.


-- 
Gražvydas
