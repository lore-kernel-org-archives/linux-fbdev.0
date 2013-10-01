From: Tom Gundersen <teg@jklm.no>
Date: Tue, 01 Oct 2013 16:45:14 +0000
Subject: Re: [PATCH v3] simplefb: print some info about the registered fb
Message-Id: <CAG-2HqVvm6b5pnS_o4b7=PR_xt6YjVabEfqoxjuj6zUJbn3dNQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAMuHMdXDAA3PgbgNrccStUZGByDXuSsMG_yJMwwUWXwMvyOfsA@mail.gmail.com>
 <1378562915-893-1-git-send-email-teg@jklm.no>
In-Reply-To: <1378562915-893-1-git-send-email-teg@jklm.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, Tom Gundersen <teg@jklm.no>, David Herrmann <dh.herrmann@gmail.com>

On Sat, Sep 7, 2013 at 4:08 PM, Tom Gundersen <teg@jklm.no> wrote:
> This is similar to the output printed by efifb.
>
> Signed-off-by: Tom Gundersen <teg@jklm.no>
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> Cc: David Herrmann <dh.herrmann@gmail.com>
> ---
> v2: also print smem_len, as requested by David
> v3: don't cast, as requested by Geert

Jean-Christophe and Tomi,

What's the status of this, did either of you pick it up for 3.12 or 3.13?

Cheers,

Tom
