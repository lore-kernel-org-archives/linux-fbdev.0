From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH 1/2] fb: Rework locking to fix lock ordering
	on takeover
Date: Wed, 23 Jan 2013 17:49:04 +0100
Message-ID: <CAKMK7uG-c3-qaMToTxYR+eeTD_NF7uJ2T76oemfb9r+zPcpz=w@mail.gmail.com>
References: <1358958309-5342-1-git-send-email-daniel.vetter@ffwll.ch>
	<1358958309-5342-2-git-send-email-daniel.vetter@ffwll.ch>
	<s5hk3r3etwt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <s5hk3r3etwt.wl%tiwai@suse.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@linux.intel.com>

On Wed, Jan 23, 2013 at 5:38 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 23 Jan 2013 17:25:08 +0100,
> Daniel Vetter wrote:
>>
>> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>>
>> Adjust the console layer to allow a take over call where the caller already
>> holds the locks. Make the fb layer lock in order.
>>
>> This s partly a band aid, the fb layer is terminally confused about the
>> locking rules it uses for its notifiers it seems.
>>
>> Signed-off-by: Alan Cox <alan@linux.intel.com>
>> [danvet: Tiny whitespace cleanup.]
>> Reported-and-tested-by: Hugh Dickins <hughd@google.com>
>> Reported-and-tested-by: Sasha Levin <levinsasha928@gmail.com>
>> References: https://lkml.org/lkml/2012/10/25/516
>> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> FYI, the latest patch of this is found in mm tree:
>   http://ozlabs.org/~akpm/mmots/broken-out/fb-rework-locking-to-fix-lock-ordering-on-takeover.patch
>
> Also I hit the same problem in another code paths (for unbind and
> unregister):
>   http://marc.info/?t=135309396400003&r=1&w=2
>
> My additional patch is found in mm tree, too:
>   http://ozlabs.org/~akpm/mmots/broken-out/fb-yet-another-band-aid-for-fixing-lockdep-mess.patch

Indeed, there's more stuff :( And I've missed the export_symbol fix
for the first patch. Still, is there any chance we can at least merge
the first one (I don't think that many people unload framebuffers)
into 3.8 with cc: stable? I'd like to get at least rid of the known
deadlocks at kms takeover time, since we have quite a few unexplained
such bug reports floating around ... Andrew, Dave?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
