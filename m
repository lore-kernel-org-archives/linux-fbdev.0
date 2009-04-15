From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] Make radeon_reinitialize_M10() absent if its reference is #ifdef'd out
Date: Wed, 15 Apr 2009 18:03:06 +0100
Message-ID: <21910.1239814986@redhat.com>
References: <1239813627.7443.18.camel@pasglop> <20090414155651.27671.36394.stgit@warthog.procyon.org.uk>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754361AbZDOREb@vger.kernel.org>
In-Reply-To: <1239813627.7443.18.camel@pasglop>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: dhowells@redhat.com, linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org, linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Nah. You ifdef it with CONFIG_PPC_PMAC, but it can be used on x86
> too (see the "BUGFIX" entries).

Ah...  I missed those:-(

David
