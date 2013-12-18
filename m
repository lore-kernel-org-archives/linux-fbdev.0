From: Dave Airlie <airlied@gmail.com>
Date: Wed, 18 Dec 2013 00:56:00 +0000
Subject: Re: [Intel-gfx] [PATCH 1/2] video/fb: Propagate error code from failing to unregister conflicting fb
Message-Id: <CAPM=9tw27eh6K8apJmicmk8-oXkK0jX8vFdbSLuzUKpv2n=c=w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387209460-9042-1-git-send-email-chris@chris-wilson.co.uk>
	<878uvk3paj.fsf@intel.com>
	<20131217121435.GF22448@nuc-i3427.alporthouse.com>
In-Reply-To: <20131217121435.GF22448@nuc-i3427.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Wilson <chris@chris-wilson.co.uk>, Jani Nikula <jani.nikula@linux.intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, dri-devel <dri-devel@lists.freedesktop.org>

On Tue, Dec 17, 2013 at 10:14 PM, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> On Tue, Dec 17, 2013 at 09:33:08AM +0200, Jani Nikula wrote:
>> On Mon, 16 Dec 2013, Chris Wilson <chris@chris-wilson.co.uk> wrote:
>> > If we fail to remove a conflicting fb driver, we need to abort the
>> > loading of the second driver to avoid likely kernel panics.
>> >
>> > Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
>> > Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
>> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> > Cc: linux-fbdev@vger.kernel.org
>> > Cc: dri-devel@lists.freedesktop.org

I'll merge this via the drm tree,

Dave.
