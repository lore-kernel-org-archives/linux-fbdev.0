From: Willy Tarreau <w@1wt.eu>
Date: Wed, 16 Sep 2020 02:25:52 +0000
Subject: Re: [PATCH] docs: fb: Remove framebuffer scrollback option for boot
Message-Id: <20200916022552.GB13409@1wt.eu>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200915222511.17140-1-unixbhaskar@gmail.com>
In-Reply-To: <20200915222511.17140-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org, daniel@ffwll.ch, yuanmingbuaa@gmail.com, nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net, torvalds@linux-foundation.org

Bhaskar,

your patches still all use very similar subjects and commit messages
which are pretty confusing as they only differ by words unrelated to
their real differences. It is important that the commit messages help
the reader guess what is being touched, so if you're splitting your
work into multiple patches, you need to indicate the difference in
each message. What I can propose to make things clearer:

    docs: fb: Remove framebuffer scrollback boot option
    docs: fb: Remove matroxfb scrollback boot option
    docs: fb: Remove sstfb scrollback boot option
    docs: fb: Remove vesafb scrollback boot option

Alternately they can all be merged into the first one under the same
name, but then the detailed commit message should specifically list
them.

In addition below:

On Wed, Sep 16, 2020 at 03:55:11AM +0530, Bhaskar Chowdhury wrote:
> This patch remove the scrollback option under boot options.
> Plus readjust the numbers for the options in that section.
> 
> Commit 973c096f6a85(vgacon: remove software scrollback support)
> Commit 50145474f6ef(fbcon: remove soft scrollback code)

This is still not clear. The message should indicate the "why" more
than the "what" which can be figured from the patch. In addition,
only the fbcon commit is a cause for these changes. Last, Greg
mentioned that the format is 'commit xxx ("subject")'.

What about this:

  The "scrollback" boot option was removed by commit 50145474f6ef
  ("fbcon: remove soft scrollback code"), but the doc for fbcon was
  not updated.  This patch updates the fbcon doc and renumbers the
  sections.

If you merge all your patches together, you can have this:

  The "scrollback" boot option was removed by commit 50145474f6ef
  ("fbcon: remove soft scrollback code"), but the fb docs were not
  updated.  This patch removes reference to this option in the fbcon,
  matroxfb, sstfb and vesafb docs and renumbers the sections as needed.

And please increase your version so that it's more obvious that this
replaces previous series. Call it v3 or v4 or whatever higher than
the highest you've ever sent so that it's easier for your readers to
ignore the older ones. Ideally after your signed-off-by you should
add a "---" line with a quick changelog indicating what changed from
the previous ones (just for reviewers, this will not be merged), for
example:

   Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
   ---
   v3: clarify message description, update all fb drivers in the same patch
   v2: reword commit message

Hoping this helps,
Willy
