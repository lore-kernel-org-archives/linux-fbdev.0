From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 20 Jul 2017 08:11:17 +0000
Subject: Re: [PATCH v2] video/console: Add dmi quirk table for x86 systems which need fbcon rotation
Message-Id: <20170720101117.6b4ea75b@endymion>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170706142839.14659-1-hdegoede@redhat.com>
In-Reply-To: <20170706142839.14659-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Hans,

On Sat, 8 Jul 2017 15:33:09 +0200, Hans de Goede wrote:
> On 07-07-17 21:02, Jean Delvare wrote:
> > On Thu,  6 Jul 2017 16:28:39 +0200, Hans de Goede wrote:  
> >> Since we are now not just checking dmi-strings but also other variables
> >> we cannot use dmi_check_system. So this commit exports dmi_matches and
> >> we use our own loop over the table entries using dmi_matches to match
> >> the dmi strings.  
> > 
> > If this is going to happen, please make this a separate commit. A
> > separate commit will be a lot easier for distribution kernel
> > maintainers (or stable/longterm kernel maintainers) to cherrypick if
> > they need it (possibly for something else than this first use case.)
> > 
> > It can still get merged through the same tree as the rest of the
> > changes, to make it easier and faster.
> > 
> > However I need to be convinced that you actually can't use
> > dmi_check_system(). Struct dmi_system_id includes a void *driver_data
> > pointer, which is passed to the callback function if DMI strings match.
>  > If you pass your struct fbcon_dmi_rotate_data through this pointer, you
>  > should be able to perform all your checks in the callback function and
>  > set initial_rotation as needed. Am I missing something?  
> 
> The dmi_system_id typically is const. The code checks the expected
> screen resolution (which is const) against the actual screen resolution,
> which is not const. So outside of using globals (ugly, racy as there might
> be more then one video output) or not making the dmi_system_id array
> const I see no other option then doing the dmi-matching inside
> the fbcon_platform_get_rotate function itself.

I gave it a try to see if it was possible at all and I have to admit
you are correct. The impossibility to pass additional (non-const) data
to dmi_check_system() make it highly unpractical for what you are
doing. Not to mention the fact that the result of the check can only be
carried through global variables, which would require locking in order
to not be racy.

Which leaves us with 2 options: exporting dmi_matches() (as you did)
under a better name or implementing a more capable dmi_check_system()
function with 2 extra parameters, one to feed additional non-const data
and one to retrieve the result of the check without relying on global
variables. I wonder if the latter option would allow cleaning up some
code in the rest of the kernel. Calls to dmi_check_system() are many
(165) and I'd be surprised if you are the first one affected by its
limitations.

My concern with the former option is that dmi_matches() operates on
struct dmi_system_id, but really only uses its matches field.
Everything else (callback, ident and driver_data) is ignored. It seems
unfortunate that external users of these functions (of which you would
be the first) would have to embed the whole structure in their const
data arrays just to be able to call dmi_matches()?

I realize the matches array is by far the largest portion of the
dmi_system_id structure, but still... The current signature of
dmi_matches() is what it is simply because it was not meant to be
exported in the first place. If we are going to export it then we
should first think of the best implementation from the user's
perspective, and then adjust the code in dmi_scan.c to cope with it.
For example, if we passed it a pointer to an array of struct
dmi_strmatch, we could get rid of the arbitrary limitation to 4
matches. Could this make your checks more robust?

> Note that the resolution check serves 2 purposes:
> 
> 1) Avoid false positives, most devices needing this have a portrait
> resolution where as your average device has a landscape resolution,
> so this check is quite useful for avoiding false positives.
> 
> 2) Avoid rotating external monitors, if one of these devices gets
> an external monitor plugged into its (mini) hdmi port and we are
> showing the fbcon there we do not want to rotate it.

I never disputed the usefulness of the checks, only the best way to
implement them.

> > (...)
> > "dmi_match" should probably have been named "dmi_field_match" instead,
> > maybe it should be renamed to that now for consistency and clarity?  
> 
> Yes I think that would be good, but outside of the scope of this patch-set.

Of course, I meant it that way. I'll take care of it separately.

-- 
Jean Delvare
SUSE L3 Support
