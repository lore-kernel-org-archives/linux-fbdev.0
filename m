From: Andrew Morton <akpm@osdl.org>
Subject: Re: [ACPI] inappropriate use of in_atomic()
Date: Fri, 11 Mar 2005 01:46:01 -0800
Message-ID: <20050311014601.166ae43d.akpm@osdl.org>
References: <20050310204006.48286d17.akpm@osdl.org>
	<20050311091142.GB22415@fi.muni.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050311091142.GB22415@fi.muni.cz>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: paulus@samba.org, jt@bougret.hpl.hp.com, javier@tudela.mad.ttd.net, linux-fbdev-devel@lists.sourceforge.net, acpi-devel@lists.sourceforge.net, linux1394-devel@lists.sourceforge.net, roland@topspin.com, linux-kernel@vger.kernel.org

Jan Kasprzak <kas@fi.muni.cz> wrote:
>
> This may be the cause of 
> 
>  http://bugme.osdl.org/show_bug.cgi?id=4150

Looks that way, yes.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
