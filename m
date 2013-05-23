From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 23 May 2013 18:35:16 +0000
Subject: Re: [PATCH v3 0/9] Clean up write-combining MTRR addition
Message-Id: <CALCETrXd=6aJwQdDL+XU9x2Pnh0V_9120iw1NHaguN1ahRhhXQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1368485053.git.luto@amacapital.net>
In-Reply-To: <cover.1368485053.git.luto@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Jerome Glisse <j.glisse@gmail.com>, Alex Deucher <alexdeucher@gmail.com>, Dave Airlie <airlied@gmail.com>, Andy Lutomirski <luto@amacapital.net>

On Mon, May 13, 2013 at 4:58 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> A fair number of drivers (mostly graphics) add write-combining MTRRs.
> Most ignore errors and most add the MTRR even on PAT systems which don't
> need to use MTRRs.
>
> This series adds new functions arch_phys_wc_{add,del} that, on PAT-less
> x86 systems with MTRRs, add MTRRs and report errors, and that do nothing
> otherwise.  (Other architectures, if any, with a similar mechanism could
> implement them.)

That's the path to upstream for this?  Should it go through drm-next?
(Sorry for possible noob question -- I've never sent in anything other
than trivial fixes to drm stuff before.)

--Andy
