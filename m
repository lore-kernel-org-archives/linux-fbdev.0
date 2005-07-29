From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Re: mttr failures on 2.6.12-mm1
Date: Fri, 29 Jul 2005 21:42:27 +0800
Message-ID: <42EA3243.10305@gmail.com>
References: <1119401665.11299.1.camel@dyn9047017102.beaverton.ibm.com> <20050728220153.269b4081.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyV9G-0007Ve-KR
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 06:43:38 -0700
Received: from wproxy.gmail.com ([64.233.184.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DyV9G-0001F0-8H
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 06:43:38 -0700
Received: by wproxy.gmail.com with SMTP id 36so606726wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Jul 2005 06:43:32 -0700 (PDT)
In-Reply-To: <20050728220153.269b4081.akpm@osdl.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, ak@muc.de

Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
>> Andi,
>>
>> I noticed these on my AMD64 box earlier. Just a warning or anything 
>> to be concerned about ? 
> 
> What happened with this one?  Looks like a bug in the vesafb code.  Do we
> know if it is fixed in 2.6.13-rc4?
> 
> (Badari is on leave - could one of the fbdev developers please help out?)
> 
> Thanks.
> 
>
>> vesafb: mode is 800x600x16, linelength=1600, pages=16
>> vesafb: scrolling: redraw
>> vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
>> mtrr: type mismatch for fc000000,1000000 old: write-back new: write-
>> combining

Range is already set to write-back, vesafb attempts to add a write-
combining mtrr (default for vesafb).

>> mtrr: size and base must be multiples of 4 kiB

This is a bug, vesafb attempts to add a size < PAGE_SIZE triggering
the messages below.

>>
>> Call Trace:<ffffffff8011662d>{mtrr_check+77} <ffffffff801169b9>{mtrr_add
>> +41}
>>        <ffffffff80647afe>{vesafb_probe+1390}
>> <ffffffff802f3f2f>{driver_probe_device+79}
>>        <ffffffff802f4010>{__device_attach+0}
>> <ffffffff802f38c6>{bus_for_each_drv+70}
>>        <ffffffff802f4079>{device_attach+89}
>> <ffffffff802f378e>{bus_add_device+62}
>>        <ffffffff802f28ad>{device_add+173}
>> <ffffffff802f575f>{platform_device_register+255}
>>        <ffffffff80647e7e>{vesafb_init+542} <ffffffff8010b24a>{init+506}
>>        <ffffffff8010e967>{child_rip+8} <ffffffff8010b050>{init+0}
>>        <ffffffff8010e95f>{child_rip+0}
>> mtrr: size and base must be multiples of 4 kiB
>>
>

Here's a patch to fix the above.  To eliminate the warning messages,
you can add the option mtrr:2 to add a write-back mtrr for vesafb. Or
just use nomtrr option.

Full changelog attached.

Tony


    vesafb: Fix mtrr bugs

    1. Fix algorithm for finding the best power of 2 size with mtrr_add().
    2. Add option to choose the mtrr type by extending the mtrr boot option:

       mtrr:n where n

        0 = no mtrr (equivalent to using the nomtrr option)
        1 = uncachable
        2 = write back
        3 = write combining (default)
        4 = write through

    From: Antonino Daplas <adaplas@pol.net>
    Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 vesafb.c |   47 ++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 36 insertions(+), 11 deletions(-)

--- a/drivers/video/vesafb.c
+++ b/drivers/video/vesafb.c
@@ -46,7 +46,7 @@ static struct fb_fix_screeninfo vesafb_f
 };
 
 static int             inverse   = 0;
-static int             mtrr      = 1;
+static int             mtrr      = 3; /* default to write-combining */
 static int	       vram_remap __initdata = 0; /* Set amount of memory to be used */
 static int	       vram_total __initdata = 0; /* Set total amount of memory */
 static int             pmi_setpal = 0;	/* pmi for palette changes ??? */
@@ -237,8 +237,8 @@ static int __init vesafb_setup(char *opt
 			pmi_setpal=0;
 		else if (! strcmp(this_opt, "pmipal"))
 			pmi_setpal=1;
-		else if (! strcmp(this_opt, "mtrr"))
-			mtrr=1;
+		else if (! strncmp(this_opt, "mtrr:", 5))
+			mtrr = simple_strtoul(this_opt+5, NULL, 0);
 		else if (! strcmp(this_opt, "nomtrr"))
 			mtrr=0;
 		else if (! strncmp(this_opt, "vtotal:", 7))
@@ -420,14 +420,39 @@ static int __init vesafb_probe(struct de
 
 	if (mtrr) {
 		unsigned int temp_size = size_total;
-		/* Find the largest power-of-two */
-		while (temp_size & (temp_size - 1))
-			temp_size &= (temp_size - 1);
-
-		/* Try and find a power of two to add */
-		while (temp_size > PAGE_SIZE &&
-			mtrr_add(vesafb_fix.smem_start, temp_size, MTRR_TYPE_WRCOMB, 1)==-EINVAL) {
-			temp_size >>= 1;
+		unsigned int type = 0;
+
+		switch (mtrr) {
+		case 1:
+			type = MTRR_TYPE_UNCACHABLE;
+			break;
+		case 2:
+			type = MTRR_TYPE_WRBACK;
+			break;
+		case 3:
+			type = MTRR_TYPE_WRCOMB;
+			break;
+		case 4:
+			type = MTRR_TYPE_WRTHROUGH;
+			break;
+		default:
+			type = 0;
+			break;
+		}
+
+		if (type) {
+			int rc;
+	
+			/* Find the largest power-of-two */
+			while (temp_size & (temp_size - 1))
+				temp_size &= (temp_size - 1);
+
+			/* Try and find a power of two to add */
+			do { 
+				rc = mtrr_add(vesafb_fix.smem_start, temp_size,
+					      type, 1);
+				temp_size >>= 1;
+			} while (temp_size >= PAGE_SIZE && rc == -EINVAL);
 		}
 	}
 	





-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
