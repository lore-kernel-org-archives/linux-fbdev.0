From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/2] OLPC + Geode fixups
Date: Tue, 25 Jul 2006 22:52:56 -0700
Message-ID: <20060725225256.b4f98887.akpm@osdl.org>
References: <20060724165046.18787.23690.stgit@cosmic.amd.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751361AbWGZFxI@vger.kernel.org>
In-Reply-To: <20060724165046.18787.23690.stgit@cosmic.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org, blizzard@redhat.com, dwmw2@redhat.com, linux-fbdev-devel@lists.sourceforge.net

On Mon, 24 Jul 2006 10:50:46 -0600
"Jordan Crouse" <jordan.crouse@amd.com> wrote:

> The following two patches are in support of the OLPC project.  I sent these
> patches before, but somewhere along the line I failed to correctly follow up.

Actually I sneakily snuck
git://git.infradead.org/users/jcrouse/geode.git#linus-upstream into -mm (as
git-geode.patch) a month ago - it's been there since 2.6.17-mm3.

So assuming that tree is being kept up-to-date, I don't need to do
anything.  Please arrange for the relevant subsystem maintainers to review
the bits of your tree which affect them (as you have done) and then send a
pull request to Linus at the appropriate time, cc'ing myself.

Unless there are significant bugfixes or this is a new subsystem, the
appropriate time would be in the post-2.6.18 two-week merge window.

And please let me know when there are -mm-affecting changes in that git tree.
Sometimes people add new branches without telling me, or they leave me
carrying abandoned stuff.
