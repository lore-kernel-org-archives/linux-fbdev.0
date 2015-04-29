From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Wed, 29 Apr 2015 21:12:33 +0000
Subject: Re: [PATCH v3 0/6] x86: document and address MTRR corner cases
Message-Id: <CAB=NE6W9ijds8T80c7Oo9HbyKxUa39THDw+Dx-qr729H3=8ODA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429647970-17479-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1429647970-17479-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Apr 21, 2015 at 1:26 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> As we phase out MTRR we need to also prepare for the flip of
> the default ioremap() behaviour from UC- to strong UC. There
> are a few remaining drivers which does not allow us to make
> a smooth transition over and which do not allow us to remove
> MTRR use. The atyfb is a good example driver and this series
> addresses the work required to avoid such regressions and
> cover MTRR size contraint use cases.
>
> This series also documents what we've learned along on the
> way in order to address removal of MTRR use and its corner
> cases.
>
> Luis R. Rodriguez (6):
>   x86: add ioremap_uc() - force strong UC, PCD=1, PWT=1
>   x86: document WC MTRR effects on PAT / non-PAT pages
>   video: fbdev: atyfb: move framebuffer length fudging to helper
>   video: fbdev: atyfb: clarify ioremap() base and length used
>   video: fbdev: atyfb: replace MTRR UC hole with strong UC
>   video: fbdev: atyfb: use arch_phys_wc_add() and ioremap_wc()

There was so far just one comment fix for this series. I'll repost the
series with the fix but other than that folks seem to be OK with this.

 Luis
