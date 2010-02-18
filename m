From: Bernie Thompson <bernie@plugable.com>
Date: Thu, 18 Feb 2010 23:03:37 +0000
Subject: Re: [PATCH 5/10] udlfb: Add functions to expose sysfs metrics and
Message-Id: <480988181002181503i58f6f4afo5b164bac879bb2a1@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1266245168.4353.3300.camel@bernie-aspireone>
In-Reply-To: <1266245168.4353.3300.camel@bernie-aspireone>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

Hi Greg,

On Thu, Feb 18, 2010 at 7:57 AM, Greg KH <greg@kroah.com> wrote:

> All new sysfs files will need a Documentation/ABI/ patch as well to
> explain the files.

I'll construct an additional patch to document the edid file (this
aught to be a standardized thing for all framebuffers, anyway - and
others have done similar/same).

And I'll do a separate one for the individual metrics if they're kept
in sysfs in the future.

>> metrics_misc
>
> This isn't.  sysfs files are "one value per file".  If you want to do
> something else, like this file, I suggest using debugfs instead.

The metrics stuff is a good candidate for moving to debugfs, I guess,
in a future patch. For now, anything in that set which violates sysfs
guidelines (metrics_misc) aught to just be removed, I guess.

These metrics have already been very helpful for comparing different
rendering algorithms, for debugging, and it's very helpful for
gathering info from end-users that may not have anything other than
sysfs set up. There are so many different hardware/software scenarios
that there's often no way to have any sense of what's happening
without more detailed instrumentation like this.

Best wishes,
Bernie
http://plugable.com/
