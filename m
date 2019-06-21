From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 21 Jun 2019 11:51:24 +0000
Subject: Re: [PATCH v2] video: fbdev: Fix Warning comparing pointer to 0 reported by coccicheck
Message-Id: <35abcd17-fff4-49e7-5331-00354818f9f7@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+7wUswLsZ7PF6Pi8Oz=9287UYZQeKCFJHP7FDtPf1Cq8PO7ag@mail.gmail.com>
 <1559560752-12314-1-git-send-email-shobhitkukreti@gmail.com>
 <CGME20190603115729epcas1p40bbcc113fd0813e328a6ffbc464751c4@epcas1p4.samsung.com>
 <CA+7wUswkGyBrnbAZrA57PcxTb1jB=dLkv9SYXT05A2fX8Mb0jw@mail.gmail.com>
In-Reply-To: <CA+7wUswkGyBrnbAZrA57PcxTb1jB=dLkv9SYXT05A2fX8Mb0jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Malaterre <malat@debian.org>, Shobhit Kukreti <shobhitkukreti@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>


On 6/3/19 1:57 PM, Mathieu Malaterre wrote:
> On Mon, Jun 3, 2019 at 1:21 PM <shobhitkukreti@gmail.com> wrote:
>>
>> From: Shobhit Kukreti <shobhitkukreti@gmail.com>
>>
>> Fixed Warning Comparing Pointer to 0. Changed return value to -ENOMEM to
>> report kzalloc failure
>>
>> drivers/video/fbdev/controlfb.c: WARNING comparing pointer to 0
>> drivers/video/fbdev/controlfb.c: WARNING comparing pointer to 0
>> drivers/video/fbdev/controlfb.c: WARNING comparing pointer to 0
>>
>> Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
>> ---
>> Changes in v2:
>>  - Modified commit message to report change in return type
>>
>>  drivers/video/fbdev/controlfb.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
>> index 7af8db2..07907c5 100644
>> --- a/drivers/video/fbdev/controlfb.c
>> +++ b/drivers/video/fbdev/controlfb.c
>> @@ -182,7 +182,7 @@ int init_module(void)
>>         int ret = -ENXIO;
>>
>>         dp = of_find_node_by_name(NULL, "control");
>> -       if (dp != 0 && !control_of_init(dp))
>> +       if (dp != NULL && !control_of_init(dp))
>>                 ret = 0;
>>         of_node_put(dp);
>>
>> @@ -580,7 +580,7 @@ static int __init control_init(void)
>>         control_setup(option);
>>
>>         dp = of_find_node_by_name(NULL, "control");
>> -       if (dp != 0 && !control_of_init(dp))
>> +       if (dp != NULL && !control_of_init(dp))
>>                 ret = 0;
>>         of_node_put(dp);
>>
>> @@ -683,8 +683,8 @@ static int __init control_of_init(struct device_node *dp)
>>                 return -ENXIO;
>>         }
>>         p = kzalloc(sizeof(*p), GFP_KERNEL);
>> -       if (p = 0)
>> -               return -ENXIO;
>> +       if (p = NULL)
> 
> nit: I would have use `!p` (same for the others above). Maybe
> checkpatch with --strict would warn for those (can't remember from top
> of my head).
> 
> Anyway:
> 
> Reviewed-by: Mathieu Malaterre <malat@debian.org>
> 
>> +               return -ENOMEM;
>>         control_fb = p; /* save it for cleanups */
>>
>>         /* Map in frame buffer and registers */
Patch queued (with some fixups, please see below) for v5.3, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


From: Shobhit Kukreti <shobhitkukreti@gmail.com>
Subject: [PATCH] video: fbdev: controlfb: fix warnings about comparing pointer to 0

Fix warnings aboout comparing pointer to 0 reported by coccicheck:

drivers/video/fbdev/controlfb.c: WARNING comparing pointer to 0
drivers/video/fbdev/controlfb.c: WARNING comparing pointer to 0
drivers/video/fbdev/controlfb.c: WARNING comparing pointer to 0

Also while at it change return value to -ENOMEM on kzalloc() failure.

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
Reviewed-by: Mathieu Malaterre <malat@debian.org>
[b.zolnierkie: minor fixups]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/controlfb.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: b/drivers/video/fbdev/controlfb.c
=================================--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -182,7 +182,7 @@ int init_module(void)
 	int ret = -ENXIO;
 
 	dp = of_find_node_by_name(NULL, "control");
-	if (dp != 0 && !control_of_init(dp))
+	if (dp && !control_of_init(dp))
 		ret = 0;
 	of_node_put(dp);
 
@@ -580,7 +580,7 @@ static int __init control_init(void)
 	control_setup(option);
 
 	dp = of_find_node_by_name(NULL, "control");
-	if (dp != 0 && !control_of_init(dp))
+	if (dp && !control_of_init(dp))
 		ret = 0;
 	of_node_put(dp);
 
@@ -683,8 +683,8 @@ static int __init control_of_init(struct
 		return -ENXIO;
 	}
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	if (p = 0)
-		return -ENXIO;
+	if (!p)
+		return -ENOMEM;
 	control_fb = p;	/* save it for cleanups */
 
 	/* Map in frame buffer and registers */
