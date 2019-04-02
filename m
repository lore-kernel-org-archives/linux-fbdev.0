From: Andreas Schwab <schwab@linux-m68k.org>
Date: Tue, 02 Apr 2019 18:09:27 +0000
Subject: [PATCH] fbcon: Don't reset logo_shown when logo is currently shown
Message-Id: <87imvwp9d4.fsf_-_@igel.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190129134350.24049-1-prarit@redhat.com>
 <20190129134350.24049-3-prarit@redhat.com> <87ftr1ed4h.fsf@igel.home>
 <8590ff59-a4fb-5a02-fda4-086476efcbe6@redhat.com>
In-Reply-To: <8590ff59-a4fb-5a02-fda4-086476efcbe6@redhat.com> (Prarit
 Bhargava's message of "Tue, 2 Apr 2019 07:31:49 -0400")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Prarit Bhargava <prarit@redhat.com>
Cc: Marko Myllynen <myllynen@redhat.com>, linux-fbdev@vger.kernel.org, Kees Cook <keescook@chromium.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Steven Rostedt <rostedt@goodmis.org>, Yisheng Xie <ysxie@foxmail.com>, Hans de Goede <hdegoede@redhat.com>, dri-devel@lists.freedesktop.org, Thierry Reding <treding@nvidia.com>

When the logo is currently drawn on a virtual console, and the console
loglevel is reduced to quiet, logo_shown must be left alone, so that it
the scrolling region on that virtual console is properly reset.

Fixes: 10993504d647 ("fbcon: Silence fbcon logo on 'quiet' boots")
Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
On Apr 02 2019, Prarit Bhargava <prarit@redhat.com> wrote:

> On 4/1/19 3:31 PM, Andreas Schwab wrote:
>> On Jan 29 2019, Prarit Bhargava <prarit@redhat.com> wrote:
>> 
>>> @@ -1066,6 +1069,9 @@ static void fbcon_init(struct vc_data *vc, int init)
>>>  
>>>  	cap = info->flags;
>>>  
>>> +	if (console_loglevel <= CONSOLE_LOGLEVEL_QUIET)
>>> +		logo_shown = FBCON_LOGO_DONTSHOW;
>>> +
>>>  	if (vc != svc || logo_shown = FBCON_LOGO_DONTSHOW ||
>>>  	    (info->fix.type = FB_TYPE_TEXT))
>>>  		logo = 0;
>> 
>> This causes the scroll region to no longer be reset when the logo is
>> removed.
>> 
>
> Andreas, my apologies but I'm not sure what you mean.  Could you elaborate on
> the broken and expected behaviour?

[    3.204286] fbcon_init: logo_shown = -1, console_loglevel = 7
[   11.840899] fbcon_init: logo_shown = 0, console_loglevel = 1
[   35.344877] fbcon_init: logo_shown = -3, console_loglevel = 1
[   35.345274] fbcon_init: logo_shown = -3, console_loglevel = 1
[   35.345622] fbcon_init: logo_shown = -3, console_loglevel = 1
[   35.345974] fbcon_init: logo_shown = -3, console_loglevel = 1
[   35.346375] fbcon_init: logo_shown = -3, console_loglevel = 1

logo_shown must not be reset when non-negative.

Andreas.
---
 drivers/video/fbdev/core/fbcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index cd059a801662..786f9aab55df 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1069,7 +1069,7 @@ static void fbcon_init(struct vc_data *vc, int init)
 
 	cap = info->flags;
 
-	if (console_loglevel <= CONSOLE_LOGLEVEL_QUIET)
+	if (logo_shown < 0 && console_loglevel <= CONSOLE_LOGLEVEL_QUIET)
 		logo_shown = FBCON_LOGO_DONTSHOW;
 
 	if (vc != svc || logo_shown = FBCON_LOGO_DONTSHOW ||
-- 
2.21.0

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
