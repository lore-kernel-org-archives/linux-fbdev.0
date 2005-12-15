From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] cleanups to matroxfb_maven
Date: Thu, 15 Dec 2005 12:13:08 +0200
Message-ID: <20051215101308.GA1744@sci.fi>
References: <20051214223132.35365ce1.khali@linux-fr.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Emq6v-0003mc-2o
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Dec 2005 02:13:17 -0800
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Emq6s-00068Y-Ir
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Dec 2005 02:13:16 -0800
Content-Disposition: inline
In-Reply-To: <20051214223132.35365ce1.khali@linux-fr.org>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>

On Wed, Dec 14, 2005 at 10:31:32PM +0100, Jean Delvare wrote:
> @@ -129,7 +129,7 @@
> =20
>  struct maven_data {
>  	struct matrox_fb_info*		primary_head;
> -	struct i2c_client*		client;
> +	struct i2c_client		client;
>  	int				version;
>  };

I think this change makes the patch unnecessarily large. Why not leave=20
the "client" as a pointer and allocate it separetely? That would reduce=20
the patch size considerably.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
