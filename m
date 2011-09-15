From: Timur Tabi <timur@freescale.com>
Date: Thu, 15 Sep 2011 16:19:32 +0000
Subject: Re: [REPOST][PATCH 2/2] video: miscellaneous minor changes to the
Message-Id: <4E722594.8060004@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1315929909-26311-2-git-send-email-timur@freescale.com>
In-Reply-To: <1315929909-26311-2-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Tormod Volden wrote:
> On Tue, Sep 13, 2011 at 6:05 PM, Timur Tabi <timur@freescale.com> wrote:
>> Make several minor, miscellaneous changes to the Freescale DIU framebuffer
>> driver.  These changes "lighten" the code by removing crud, fixing small
>> bugs, and fixing some coding style problems.  These changes will make it
>> easier to make more substantial fixes in the future.
> 
> It would be much easier to review this if it is split up into several
> commits. At least have the whitespace fixes in a separate commit, and
> also the actual bug fixes. "git add -p" is your friend.

Ok.

> 
>> 1. Fix incorrect indentation and spacing with some code.
>> 2. Remove debug printks (they don't actually help in debugging the code).
>> 3. Clean up some other printks (e.g. use pr_xxx, clean up the text, etc).
>> 4. Remove the "default" videomode object since it's just a dupe of the
>>   first element in the videomode array.
>> 5. Remove some superfluous local variables.
>> 6. Rename ofdev to pdev, since it's a platform device not an OF device.
>> 7. Fix some device tree operations.
>> 8. Fix some build warnings.
>> 9. Removed some unused structures from the header file.
>> 10. Other minor bug fixes and changes.
> 
> I would have found natural to split it up into commits like for
> example: 1, 2+3, 4, 5+8+9, 10.

Ok.

> 
>> @@ -217,59 +201,59 @@ struct mfb_info {
>>        int x_aoi_d;            /* aoi display x offset to physical screen */
>>        int y_aoi_d;            /* aoi display y offset to physical screen */
>>        struct fsl_diu_data *parent;
>> -       u8 *edid_data;
>> +       void *edid_data;
>>  };
> 
> Why do you convert edid_data from pointer to u8 to pointer to void?

Hmm.. Normally I do that to eliminate a typecast, but that didn't happen in this
case.  I guess I'll leave it as a u8*.

-- 
Timur Tabi
Linux kernel developer at Freescale

