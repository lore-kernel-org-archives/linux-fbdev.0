From: James Morris <jmorris@namei.org>
Date: Wed, 04 Apr 2012 04:06:19 +0000
Subject: Re: [PATCH] userns: Replace netlink uses of cap_raised with capable.
Message-Id: <alpine.LRH.2.02.1204041404540.16594@tundra.namei.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <m1mx6sz2f2.fsf@fess.ebiederm.org>
In-Reply-To: <m1mx6sz2f2.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Serge E. Hallyn" <serge@hallyn.com>, Philipp Reisner <philipp.reisner@linbit.com>, Patrick McHardy <kaber@trash.net>, Andrew Morgan <morgan@kernel.org>, Vasiliy Kulikov <segoon@openwall.com>, David Howells <dhowells@redhat.com>, Neil Brown <neilb@suse.de>, Michal Januszewski <spock@gentoo.org>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-raid@vger.kernel.org

On Tue, 3 Apr 2012, Eric W. Biederman wrote:

> In the initial user_namespace the only difference between  between
> cap_raised(current_cap(), CAP_SYS_ADMIN) and capable(CAP_SYS_ADMIN)
> are a few sanity checks and the fact that capable(CAP_SYS_ADMIN)
> sets PF_SUPERPRIV if we use the capability.
> 
> Since we are going to be using root privilege setting PF_SUPERPRIV
> seems the right thing to do.

Agreed.

Reviewed-by: James Morris <james.l.morris@oracle.com>


- James
-- 
James Morris
<jmorris@namei.org>
