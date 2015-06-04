From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Thu, 04 Jun 2015 16:24:54 +0000
Subject: Re: [PATCH v3 2/3] video: fbdev: vesafb: add missing mtrr_del() for added MTRR
Message-Id: <CAB=NE6Xg-Wmy5BCJf7qkrJsc19f49n4xkHw6vfzQWSiziAuDVA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429648850-17902-1-git-send-email-mcgrof@do-not-panic.com>
 <1429648850-17902-3-git-send-email-mcgrof@do-not-panic.com>
 <555C594E.1010607@ti.com> <20150520194632.GY23057@wotan.suse.de>
 <556FE863.9070000@ti.com>
In-Reply-To: <556FE863.9070000@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cocci@systeme.lip6.fr

On Wed, Jun 3, 2015 at 10:55 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
>
> On 20/05/15 22:46, Luis R. Rodriguez wrote:
>> On Wed, May 20, 2015 at 12:52:14PM +0300, Tomi Valkeinen wrote:
>
>>> Hmm, this looks a bit odd... You're removing the pseudo_palette, and
>>> using its memory for mtrr cookie?
>>
>> You are totally right, sorry, will spin a v3.
>
> Did you ever send a new version (v4 actually), or have I somehow missed it?

Crap no, sorry about that, will send it out right away.

 Luis
